# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mini_transformer/version"

Gem::Specification.new do |s|
  s.name        = "mini_transformer"
  s.version     = MiniTransformer::VERSION
  s.authors     = ["r6p"]
  s.summary     = <<-SUM
                      A gem to bind portions of an xml document to an OpenStruct 
                      object and transform that object to some new output format 
                      using ERB.
                  SUM
  s.description = <<-DESC
                      Given an xml document, a json metadata file, some mappings,
                      and an erb template, one should be able to transform the
                      xml document into any type of text output.
                  DESC

  s.rubyforge_project = "mini_transformer"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_runtime_dependency "yajl-ruby"
  s.add_runtime_dependency "nokogiri"
end
