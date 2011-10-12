require_relative '../spec_helper'
require 'mini_transformer/input'

describe MiniTransformer::Input do
  
  describe "#initialize" do 

    it "should accept json metadata and xml" do
      json = helper.read_spec_data("input.json")
      xml = helper.read_spec_data("input.xml")
      input = MiniTransformer::Input.new(json, xml)
      input.metadata.wont_be_nil
      input.dom.wont_be_nil
    end

    it "should raise an error when provided json is nil" do
      xml = helper.read_spec_data("input.xml")
      lambda {
        MiniTransformer::Input.new(nil, xml)
      }.must_raise(TypeError)
    end
    
    it "should raise an error when provided xml is nil" do
      json = helper.read_spec_data("input.json")
      lambda {
        MiniTransformer::Input.new(json, nil)
      }.must_raise(RuntimeError)
    end

    it "should raise an error when provided json is invalid" do
      xml = helper.read_spec_data("input.xml")
      lambda {
        MiniTransformer::Input.new("not really json", xml)
      }.must_raise(JSON::ParserError)
    end
    
    it "should raise an error when provided xml is invalid" do
      json = helper.read_spec_data("input.json")
      lambda {
        MiniTransformer::Input.new(json, "<not> <<valid xml>")
      }.must_raise(Nokogiri::XML::SyntaxError)
    end
   end
end
