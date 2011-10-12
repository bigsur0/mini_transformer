require_relative '../spec_helper'
require 'mini_transformer/mapper'

describe MiniTransformer::Mapper do

  describe "#initialize" do

    it "should accept some mapping rules" do
      json = helper.read_spec_data("input.json")
      xml = helper.read_spec_data("input.xml")
      input = MiniTransformer::Input.new(json, xml)
      mappings = helper.read_spec_data("book-mappings.yml")
      MiniTransformer::Mapper.new(mappings).wont_be_nil
    end

    it "should raise an error when mappings are nil" do
      lambda{
        MiniTransformer::Mapper.new(nil)
      }.must_raise(TypeError)
    end

    it "should raise an error when mappings are invalid" do
      lambda{
        MiniTransformer::Mapper.new("key: value:")
      }.must_raise(Psych::SyntaxError)
    end

  end

  describe "#map" do

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

    it "should raise error when input is nil" do
      mappings = helper.read_spec_data("book-mappings.yml")
      lambda{
        MiniTransformer::Mapper.new(mappings).map(nil)
      }.must_raise(NoMethodError)
    end

    it "should raise error when input is a string" do
      mappings = helper.read_spec_data("book-mappings.yml")
      lambda{
        MiniTransformer::Mapper.new(mappings).map("")
      }.must_raise(NoMethodError)
    end

  end

end
