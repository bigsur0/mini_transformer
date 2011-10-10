require 'minitest/autorun'

require 'rubygems'
require 'bundler/setup'

$:.unshift File.dirname(__FILE__) + '/../lib'
require 'mini_transformer'

class SpecHelper
  def data_dir
    @data_dir ||= "#{File.dirname(__FILE__)}/data"
  end
  
  def read_spec_data(file)
    open("#{File.dirname(__FILE__)}/data/#{file}").read
  end
end

def helper
  @helper ||= SpecHelper.new
end
