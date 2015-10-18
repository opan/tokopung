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
require "rspec-rails"
require "factory_girl_rails"
require "capybara"
require "database_cleaner"
require "devise"
require "pundit"

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

      # setting up Core engine generators
      config.generators do |g|
        g.template_engine :haml
        g.test_framework    :rspec, :fixture => false
        g.fixture_replacement :factory_girl, :dir => "spec/factories"
      end

      if Rails.env.eql? "test"
        config.action_mailer.default_url_options = {host: "localhost", port: 3000}
      end

      # load our mesin views to default paths, to make shorten call for rendering views
      # ex: "dashboard/index" instead of "mesin/dashboard/index"
      paths["app/views"] << "app/views/mesin"

    end # end Engine
  end # end Core
end # end Mesin
