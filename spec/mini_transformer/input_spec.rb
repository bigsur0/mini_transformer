require_relative '../spec_helper'
require 'mini_transformer/input'

describe MiniTransformer::Input do
  it "should accept json metadata and xml" do
    json = helper.read_spec_data("input.json")
    xml = helper.read_spec_data("input.xml")
    input = MiniTransformer::Input.new(json, xml)
    input.metadata.wont_be_nil
    input.dom.wont_be_nil
  end
end
