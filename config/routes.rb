Rails.application.routes.draw do
  namespace :admin do
    #root to: 'home#index'
    resources :payment_methods do
      put :active_method, on: :member
      put :desactive_method, on: :member
    end
  end
  
  as :admin do
    get 'admins', :to => 'admin/home#index', :as => :admin_root # Rails 3
  end

  root to: "home#index"
  
  devise_for :admins
  devise_for :users

  namespace :user do
    resources :client_companies, only: %i[show new create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end