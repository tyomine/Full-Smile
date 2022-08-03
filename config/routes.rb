Rails.application.routes.draw do
  
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  scope module: :public do
    root to: "homes#top"
    get 'about' => 'homes#about'
    
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    
    resources :posts, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
      resource :likes, only: [:create, :destroy]
      get 'posts/likes' => "likes#index"
      resources :comments, only: [:create, :destroy]
    end
  end  
  
  
  namespace :admin do
    root to: "homes#top"
    
    resources :users, only: [:index, :show]
    resources :posts, only: [:show]
    
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
