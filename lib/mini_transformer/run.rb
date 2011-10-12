require 'ostruct'

module MiniTransformer
  class Run
  
    attr_reader :input, :mapper, :transformer
    private :mapper, :transformer
  
    def initialize(params)
      @mapper = Mapper.new(params.mappings)
      @transformer = Transformer.new(params.template)
    end
  
    def run(input)
      model = mapper.map(input)
      transformer.render(model)
    end
  
  
    class << self
      def on_dir(options)
        opts = OpenStruct.new(options) 
        opts.metadata = read_file("#{opts.work_dir}/#{opts.metadata}")
        opts.input = read_file("#{opts.work_dir}/#{opts.input}")
        opts.mappings = read_file("#{opts.work_dir}/#{opts.mappings}")
        opts.template = read_file("#{opts.work_dir}/#{opts.template}")
  
        runner = Run.new(opts)
        input = Input.new(opts.metadata, opts.input)
        output_filename = opts.output ||= input.metadata.uid
        output = Output.new
        write_file(opts.work_dir, output_filename) do |f| 
          output.write(f, runner.run(input))
        end
      end
  
      def read_file(path)
        File.open(path, 'r').read
      end
      private :read_file

      def write_file(output_dir, file_name)
        File.open([output_dir, file_name].join("/"), 'w') do |f| 
          yield f
          f.flush
        end
      end
    end
  end
end
