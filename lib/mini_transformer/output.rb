#require 'file' - Just a reminder that we are dependent on core file

module MiniTransformer
  class Output
   
    def write(stream, output)
      stream.write(output)
      true
    rescue
      false
    end
  
  end
end
