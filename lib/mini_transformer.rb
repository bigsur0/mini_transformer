require "mini_transformer/version"
require "mini_transformer/input"
require "mini_transformer/mapper"
require "mini_transformer/transformer"
require "mini_transformer/output"
require "mini_transformer/run"

module MiniTransformer

  def self.run_on_dir(options)
    MiniTransformer::Run.on_dir(options)
  end
end


