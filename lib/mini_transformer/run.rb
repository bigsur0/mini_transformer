require 'ostruct'

module MiniTransformer
  class Run
  
    attr_reader :input, :mapper, :transformer
  
    def initialize(params)
      @input = Input.new(params.metadata, params.xml)
      @mapper = Mapper.new(params.mappings)
      @transformer = Transformer.new(params.template)
    end
  
    def run
      model = @mapper.map(@input)
      @transformer.render(model)
    end
  
  
    class << self
      def on_dir(options)
        opts = OpenStruct.new(options) 
        opts.metadata = read_file("#{opts.work_dir}/#{opts.metadata}")
        opts.xml = read_file("#{opts.work_dir}/#{opts.input}")
        opts.mappings = read_file("#{opts.work_dir}/#{opts.mappings}")
        opts.template = read_file("#{opts.work_dir}/#{opts.template}")
  
        runner = Run.new(opts)
        opts.output = opts.output ||= runner.input.metadata.uid
        output = Output.new(opts.work_dir)
        output.write(opts.output, runner.run)
      end
  
      def read_file(path)
        File.open(path, 'r').read
      end
      private :read_file
    end
  end
end
