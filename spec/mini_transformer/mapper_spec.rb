require_relative '../spec_helper'
require 'mini_transformer/mapper'

describe MiniTransformer::Mapper do

  it "should accept some mapping rules" do
    json = helper.read_spec_data("input.json")
    xml = helper.read_spec_data("input.xml")
    input = MiniTransformer::Input.new(json, xml)
    mappings = helper.read_spec_data("book-mappings.yml")
    MiniTransformer::Mapper.new(mappings).wont_be_nil
  end

  it "should map input to an OpenStruct" do
    json = helper.read_spec_data("input.json")
    xml = helper.read_spec_data("input.xml")
    input = MiniTransformer::Input.new(json, xml)
    mappings = helper.read_spec_data("book-mappings.yml")
    book = MiniTransformer::Mapper.new(mappings).map(input)

    book.must_be_kind_of(OpenStruct)
    book.metadata.title.wont_be_nil
    book.metadata.type.wont_be_nil

    book.key_list.wont_be_nil
    book.key_list.css_class.wont_be_nil
    book.key_list.name.wont_be_nil
    book.key_list.name.css_class.wont_be_nil
    book.key_list.name.value.wont_be_nil

    book.key_list_entries.wont_be_nil
    book.key_list_entries.css_class.wont_be_nil
    book.key_list_entries.values.must_be_kind_of(Array)
    book.key_list_entries.values.each do |key_list_entry|
      key_list_entry.key_name.css_class.wont_be_nil
      key_list_entry.key_name.value.wont_be_nil
    end

  end

end
