module Mesin
  module ApplicationHelper
    def asset_exists? asset_path
      Rails.application.assets.find_asset asset_path
    end
  end # end ApplicationHelper
end # end Mesin
