Rails.application.routes.draw do
  
  namespace :user do
    root to: 'home#index'
    resources :client_companies, only: %i[show new create edit update] do
      resources :boleto_accounts
    end
  end
  root to: "home#index"

  devise_for :admins
  devise_for :users

  namespace :admin do
    root to: 'home#index'
    resources :payment_methods do
      put :active_method, on: :member
      put :desactive_method, on: :member
    end
  end
  
end