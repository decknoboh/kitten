Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in',as: 'guest_sign_in'
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    get 'users/my_page' => 'users#my_page', as: 'my_page'
    get 'users/information/edit'=> 'users#edit', as: 'edit_information_users'
    patch 'users/information' => 'users#update', as: 'update_information_users'
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/goodbye' => 'users#goodbye', as: 'goodbye'
    resources :users, only: [:show] do
      get 'posts'
      get 'comments'
      get 'favorites'
    end

    resources :posts do
      resources :comments, only: [:create,:edit,:update,:destroy]
      resources :favorites, only: [:create, :destroy]
    end
  end

  get 'admin' => 'admin/homes#top', as: 'admin_home_top'

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:show, :destroy]
    resources :comments, only: [:index, :destroy]
  end
end
