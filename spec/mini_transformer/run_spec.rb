require_relative '../spec_helper'
require 'mini_transformer/run'

describe MiniTransformer::Run do

  
  describe ".on_dir" do

    it "should run on a directory and generate output" do
      output_filename = "book.html.#{Time.now.to_i}_spec.out"
      MiniTransformer::Run.on_dir(
        :work_dir  =>  helper.data_dir,
        :metadata  =>  "input.json",
        :input     =>  "input.xml",
        :template  =>  "book.html.erb",
        :mappings  =>  "book-mappings.yml",
        :output    =>  output_filename
      )
      example = helper.read_spec_data("TP40010215.html")
      transformed = helper.read_spec_data(output_filename)
      transformed.must_equal example
    end


    it "should raise a syntax error with invalid xml" do
      output_filename = "book.html.#{Time.now.to_i}_spec.out"
      lambda{ 
        MiniTransformer::Run.on_dir(
          :work_dir  =>  helper.data_dir,
          :metadata  =>  "input.json",
          :input     =>  "invalid.xml",
          :template  =>  "book.html.erb",
          :mappings  =>  "book-mappings.yml",
          :output    => output_filename 
      )
      }.must_raise(Nokogiri::XML::SyntaxError)
    end
  
  end
end
