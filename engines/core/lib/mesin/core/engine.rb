# load engine dependencies
require "haml-rails"
require "pg"
require "twitter-bootstrap-rails"
require "less-rails"
require "sass-rails"
require "therubyracer"
require "ckeditor"
require "mini_magick"
require "carrierwave"
require "kaminari"
require "jquery-rails"
require "uglifier"
require "coffee-rails"

module Mesin
  module Core
    class Engine < ::Rails::Engine
      isolate_namespace Mesin
    end # end Engine
  end # end Core
end # end Mesin
