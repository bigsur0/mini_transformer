require 'erb'

module MiniTransformer
  class Transformer 
    
    attr_reader :renderer
    private :renderer
    
    def initialize(erb_template)
      @renderer = ERB.new(erb_template.strip, 0, '%<>-')
    end
  
    def render(context)
      renderer.result( context.instance_eval{ binding } )
    end
  end
end
