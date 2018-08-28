Rails.application.routes.draw do
  # URLがルートだった場合の飛ぶ先を変更
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]
end