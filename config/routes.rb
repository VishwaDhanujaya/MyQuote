Rails.application.routes.draw do
  root "public#home"

  get "/public/quotes", to: "public#quotes", as: :public_quotes
  get "/public/categories/:id", to: "public#by_category", as: :public_category

  get "/stylesheets/application.css", to: "stylesheets#application", as: :legacy_application_stylesheet

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, only: %i[new create edit update]
  resources :quotes
  resources :philosophers
  resources :categories, except: %i[show]

  namespace :admin do
    resources :users do
      member do
        patch :promote
        patch :demote
        patch :set_status
      end
    end
  end
end
