Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "home#index"
  put "/orders/rating", to: "orders#rating", as: :order_rating
  get "/orders/all", to: "orders#all_orders", as: :all_orders
  resources :menus, :menu_items, :orders, :order_items, :users
  get "/cart", to: "orders#cart", as: :cart
  get "/pending_orders", to: "orders#pending_orders", as: :pending_orders
  get "/sign_in", to: "sessions#new", as: :new_session
  post "/sign_in", to: "sessions#create", as: :session
  delete "/sign_out", to: "sessions#destroy", as: :destroy_session
  get "/sales_report", to: "orders#report", as: :report
  get "/date_wise_report", to: "orders#date_wise_report", as: :date_wise_report
  put "/activate", to: "menu_items#activate", as: :menu_items_activate
  post "/clerk", to: "users#clerk", as: :clerk
  post "/clerk_update", to: "users#clerk_update", as: :clerk_update
end
