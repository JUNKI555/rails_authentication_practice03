Rails.application.routes.draw do
  devise_for :user_recovers
  devise_for :user_trackings
  devise_for :user_database_authentications
  devise_for :user_registrations
  devise_for :users
  get 'home/index'

  root to: "home#index"
  
  ## 開発環境用letter_opener
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
