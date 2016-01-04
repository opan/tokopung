Mesin::Core::Engine.routes.draw do

  namespace :admin do
    resources :dashboards, only: :index 
    resources :accounts, only: :index do
      collection do
        put :update_profile
      end
    end # end resources :accounts
  end # end namespace :admin


  # if install Devise inside an Engine,
  # make sure to add 'module: :devise' to tell Devise that we're running inside en Engine
  devise_for :users, class_name: "Mesin::User", module: :devise, controllers: {registrations: "mesin/registrations"}
  
  root to: "admin/dashboards#index"
end
