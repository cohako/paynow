Rails.application.routes.draw do  
  namespace :user do
    root to: 'home#index'
    resources :client_companies, only: %i[show new create edit update], param: :token do
      resources :boleto_accounts
      resources :card_accounts
      resources :pix_accounts
      resources :client_products, param: :product_token
      resources :payment_methods, only: %i[index show]

      put :regenerate_token, on: :member

    end
  end
  namespace :admin do
    root to: 'home#index'
    resources :client_companies, only: %i[index show], param: :token
    resources :orders, only: %i[show], param: :order_token do
      resources :refused_histories, only: %i[show create]
      resources :receipts, only: %i[new create show], param: :receipt_token
    end
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
      resources :client_externals, only: %i[create], param: :client_external_token
      resources :orders, only: %i[index show create], param: :order_token
    end
  end
end