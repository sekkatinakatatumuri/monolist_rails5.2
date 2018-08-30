Rails.application.routes.draw do
  # URLがルートだった場合の飛ぶ先を変更
  root to: 'toppages#index'
  
  # URL の見栄えを考慮して、個別にルーティングを設定
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # URL の見栄えを考慮して、newだけ個別にルーティングを設定
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create]
  
  resources :items, only: [:show, :new]
  resources :ownerships, only: [:create, :destroy]
  
  get 'rankings/want', to: 'rankings#want'
  # get 'rankings/have', to: 'rankings#have'
end