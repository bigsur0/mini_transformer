require_relative '../spec_helper'
require 'mini_transformer/transformer'
require 'ostruct'

describe MiniTransformer::Transformer do

  before do
    @erb = "<%= title %>"
    @title = "Ruby 1.9" 
  end

  describe "#initialize" do
    it "should accept an erb template" do
      MiniTransformer::Transformer.new(@erb).wont_be_nil
    end

    it "should raise an error when erb template is nil" do
      lambda{
        MiniTransformer::Transformer.new(nil)
      }.must_raise(NoMethodError)
    end
  end

  describe "#render" do

    it "should render" do
      context = MiniTest::Mock.new
      context.expect(:title,  @title)
      rendered = MiniTransformer::Transformer.new(@erb).render(context)
      rendered.must_equal @title
    end

    it "should render the same data in the example output" do
      json = helper.read_spec_data("input.json")
      xml = helper.read_spec_data("input.xml")
      input = MiniTransformer::Input.new(json, xml)
      mappings = helper.read_spec_data("book-mappings.yml")
      book = MiniTransformer::Mapper.new(mappings).map(input)

      book_template = helper.read_spec_data("book.html.erb")
      rendered = MiniTransformer::Transformer.new(book_template.strip).render(book)
      example_output = helper.read_spec_data("TP40010215.html")
      rendered.must_equal example_output
    end
    it "should raise an error when erb template is invalid" do
      lambda{
        MiniTransformer::Transformer.new("<%= invalid.bar)) %>").render(OpenStruct.new)
      }.must_raise(SyntaxError)
    end

  end

end
 
