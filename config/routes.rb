Rails.application.routes.draw do
  
  devise_for :admins
  root to: "home#index"
  devise_for :users
  namespace :user do
    resources :client_companys, only: %i[show new create]
  end
  namespace :admin do
    resources :payment_method
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
