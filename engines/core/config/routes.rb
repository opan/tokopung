Mesin::Core::Engine.routes.draw do

  namespace :admin do
    resources :dashboards, only: :index 
    resources :accounts, only: :index 
  end


  # if install Devise inside an Engine,
  # make sure to add 'module: :devise' to tell Devise that we're running inside en Engine
  devise_for :users, class_name: "Mesin::User", module: :devise, controllers: {registrations: "mesin/registrations"}
  
  root to: "dashboards#index"
end
