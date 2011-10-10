require 'ostruct'
require 'nokogiri'
require 'json'

module MiniTransformer
  class Input
    
    attr_reader :metadata, :dom
  
    def initialize(metadata, xml)
      json = JSON.parse(metadata)
      @metadata = OpenStruct.new(json)
      @dom = Nokogiri::XML(xml)
    end
  
  end
end
