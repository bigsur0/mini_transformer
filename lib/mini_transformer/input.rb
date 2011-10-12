require 'ostruct'
require 'nokogiri'
require 'json'

module MiniTransformer
  class Input
    
    attr_reader :metadata, :dom
  
    def initialize(metadata, xml)
      json = JSON.parse(metadata)
      @metadata = OpenStruct.new(json)
      raise "Provided xml was nil" unless xml
      @dom = Nokogiri::XML(xml){ |config| config.strict }
    end
  
  end
end
