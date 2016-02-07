Mesin::Core::Engine.routes.draw do

  namespace :admin do
    resources :dashboards, only: :index 
    resources :accounts, only: :index do
      member do
        put :update_profile
        post :add_user_emails
        delete :change_user_emails, to: "accounts#delete_user_email"
        patch :update_password
        delete :delete_account
        patch :lock_account
      end
    end # end resources :accounts
    
  end # end namespace :admin


  # if install Devise inside an Engine,
  # make sure to add 'module: :devise' to tell Devise that we're running inside en Engine
  devise_for :users, class_name: "Mesin::User", module: :devise, controllers: {registrations: "mesin/registrations"}
  
  root to: "admin/dashboards#index"
end
