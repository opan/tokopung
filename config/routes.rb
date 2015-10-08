Rails.application.routes.draw do
  mount Mesin::Core::Engine => "/", as: "main"

end
