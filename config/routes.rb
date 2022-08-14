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
    
    get "search" => "searches#search"
    
    
    resources :users, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      
      # 退会確認画面
      get '/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
      # 論理削除用のルーティング
      patch '/withdrawal' => 'users#withdrawal', as: 'withdrawal'
      
    resources :notifications, only: :index do
      collection do
        delete 'destroy_all' => 'notifications#destroy_all', as: 'destroy_all'
      end
    end
      
      resources :reports, only: [:new, :create]
      
      #idを持たせるため
      member do
        get :likes
      end
    end
    
    resources :posts, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
      resource :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    
  end  
  
  
  namespace :admin do
    root to: "homes#top"
    
    resources :users, only: [:index, :show, :edit, :update] do 
      # 退会確認画面
      get '/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
      # 論理削除用のルーティング
      patch '/withdrawal' => 'users#withdrawal', as: 'withdrawal'
    end
    resources :reports, only: [:index, :show, :update]
      
    resources :posts, only: [:show, :destroy]
    
  end
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
