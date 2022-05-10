Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 devise_for :users
  root to: 'homes#top'
  get "home/about"=>"homes#about"

  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end



  # ネストさせる
  resources :users, only: [:index,:show,:edit,:update] do
  #フォローする、外す(いいね関係と同じでresourceに注意)
    resource :relationships, only: [:create, :destroy]
  #フォローした人一覧
    get 'followings' => 'relationships#followings', as: 'followings'
  #フォローされた人一覧
    get 'followers' => 'relationships#followers', as: 'followers'
 end

 get '/search' => 'searches#search'

  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]
end