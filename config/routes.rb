Rails.application.routes.draw do
  
  root to: "home#index"
  devise_for :users
  namespace :user do
    resources :client_companys, only: %i[show new create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
