Rails.application.routes.draw do
  
  
  namespace :user do
    root to: 'home#index'
    resources :client_companies, only: %i[show new create edit update], param: :token do
      resources :boleto_accounts
      resources :card_accounts
      resources :pix_accounts
      resources :client_product, param: :product_token
      resources :payment_methods, only: %i[index show]

      put :regenerate_token, on: :member

    end
  end
  namespace :admin do
    root to: 'home#index'
    resources :payment_methods do
      put :active_method, on: :member
      put :desactive_method, on: :member
    end
  end
  root to: "home#index"

  devise_for :admins
  devise_for :users

  namespace :api do
    namespace :v1 do
    end
  end
end