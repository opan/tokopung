module Mesin
  module ApplicationHelper
    def asset_exists? asset_path
      Rails.application.assets.find_asset asset_path
    end

    def active_menu? path
      current_page?(path) ? "active": ""
    end
  end # end ApplicationHelper
end # end Mesin
