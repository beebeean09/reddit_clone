Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  resources :subs, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
    resources :posts, only: [:new, :create]
  end
  resources :posts, only: [:show, :edit, :update, :destroy] do
    resources :comments, only: [:new]
  end

  resources :comments, only: [:show, :create]

  root :to => "subs#index"
end
