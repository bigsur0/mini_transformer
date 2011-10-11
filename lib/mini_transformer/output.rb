#require 'file' - Just a reminder that we are dependent on core file

module MiniTransformer
  class Output
   
    attr_reader :output_dir
    private :output_dir

    def initialize(output_dir)
      @output_dir = output_dir
    end
  
    def write(file_name, output)
      File.open([output_dir, file_name].join("/"), 'w') do |f| 
        f.write(output)
        f.flush
      end
      true
    rescue
      false
    end
  
  end
end
