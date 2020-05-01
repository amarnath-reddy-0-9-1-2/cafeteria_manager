Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :menus
  resources :menu_items
  resources :orders
  resources :order_items
  resources :users
  get "/", to: "home#index"
  get "/cart", to: "orders#cart", as: "cart"
  get "/pending_orders", to: "orders#pending_orders", as: "pending_orders"
  get "/sign_in", to: "sessions#new", as: :new_session
  post "/sign_in", to: "sessions#create", as: :session
end
