# load engine dependencies
require "haml-rails"
require "pg"

module Mesin
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace Mesin
    end # end Engine
  end # end Core
end # end Mesin
