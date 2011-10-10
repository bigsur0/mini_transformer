#require 'file' - Just a reminder that we are dependent on core file

module MiniTransformer
  class Output
    
    def initialize(output_dir)
      @output_dir = output_dir
    end
  
    def write(file_name, output)
      File.open([@output_dir, file_name].join("/"), 'w') do |f| 
        f.write(output)
        f.flush
      end
    end
  
  end
end
