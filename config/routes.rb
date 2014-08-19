ListenLater::Application.routes.draw do

  resources :series do
    resources :subscriptions, only: :create
    resources :sources, only: [:index, :show]
  end

  resources :categories, only: [:show, :index]
  resources :listens, only: [:create, :show]


  match '/', :controller => :pages, :action => :home
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    delete '/users/disconnect/:provider',
      :to => 'users#disconnect_omniauth_provider',
      :as => 'disconnect_omniauth_provider'
  end

  match 'welcome' => "users#welcome"

  match 'bookmarklet' => "users#bookmarklet"
  post 'bookmark', :controller => :sources, :action => :create

  resources :sources do
    collection do
      get 'recent'
      get 'popular'
    end
  end

  resources :subscriptions do
    resources :sources
  end

  resources :users do
    resources :sources
    resources :subscriptions
  end

  resources :tags, only: [:show, :index]


  root :to => 'pages#home'

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
