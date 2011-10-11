require 'mini_transformer/input'
require 'yaml'
require 'ostruct'

module MiniTransformer
  class Mapper
    
    attr_reader :mapping_config
    private :mapping_config

    def initialize(mappings)
      @mapping_config = YAML.load(mappings)
    end
  
    def map(input)
      bound = OpenStruct.new(:metadata => input.metadata)
      mapping_config.each do |field, config|
        bound.send("#{field}=", map_xml(input.dom, field, config))
      end
      bound
    end
  
    def map_xml(dom, field, config)
      return nil unless dom #or (dom === Array and dom.empty?)
  
      mapped = OpenStruct.new
      mapped.css_class = config["css_class"]
  
      fragment = config["xpath"] ? dom.xpath(config["xpath"]) : dom
      
      if config["collection_xpath"] 
        collection_nodeset = dom.xpath(config["collection_xpath"]) 
        mapped.values = collection_nodeset.collect do |frag_dom|
          map_xml(frag_dom, field, config.reject{|k,v| k =~ /xpath/} )
        end
      elsif fragment && config["fields"]
        config["fields"].each do |field, config|
          child = map_xml(fragment, field, config)
          mapped.send("#{field}=", child) 
        end
      elsif fragment && fragment.children.size == 1 && fragment.children.first.text?
        mapped.value = fragment.children.first.text
      end
  
      mapped
    end
  
    private :map_xml
  
  end
end
