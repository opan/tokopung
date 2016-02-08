Rails.application.routes.draw do
  mount Mesin::Core::Engine => "/", as: "mesin"

  # set root path for main_app
  root to: "admin/dashboards#index"
end
