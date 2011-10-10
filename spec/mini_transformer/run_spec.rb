require_relative '../spec_helper'
require 'mini_transformer/run'

describe MiniTransformer::Run do

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

end
