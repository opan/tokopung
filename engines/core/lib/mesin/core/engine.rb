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

      # load migration file to main apps
      initializer :append_migrations do |app|
        unless app.root.to_s.match(root.to_s)
          config.paths["db/migrate"].expanded.each do |expanded_path|
            app.config.paths["db/migrate"] << expanded_path
          end
        end
      end # end :append_migrations
      
    end # end Engine
  end # end Core
end # end Mesin
