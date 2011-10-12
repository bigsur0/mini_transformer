require_relative '../spec_helper'
require 'mini_transformer/output'

describe MiniTransformer::Output do

  describe "#initialize" do
    it "should accept a directory" do
      MiniTransformer::Output.new(helper.data_dir).wont_be_nil
    end
  end

  describe "#write" do 

    it "should write output to file" do
      output = MiniTransformer::Output.new
      stream = MiniTest::Mock.new
      output_body = "some output"
      stream.expect(:write, nil, [output_body])
      output.write(stream, output_body)
      stream.verify.must_be_same_as true
    end

    it "should return false when file_name provided is nil" do
      output = MiniTransformer::Output.new
      output.write(nil, "some output").must_be_same_as false
    end

    it "should return true when output provided is nil" do
      output = MiniTransformer::Output.new
      stream = MiniTest::Mock.new
      output_body = nil 
      stream.expect(:write, nil, [nil])
      output.write(stream, output_body).must_be_same_as true
      stream.verify.must_be_same_as true
    end

  end
end
 
