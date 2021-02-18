Rails.application.routes.draw do
  devise_for :user_registrations, path:'users', :controllers => {
    :confirmations => 'users/confirmations',
  }

  devise_for :user_database_authentications, path:'users', :controllers => {
    :passwords => 'users/passwords',
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
  }

  devise_for :users

  get 'home/index'

  root to: "home#index"
  
  ## 開発環境用letter_opener
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
