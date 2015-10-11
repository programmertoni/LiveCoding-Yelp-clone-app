Rails.application.routes.draw do
  root 'reviews#recent'

  get  '/about-us',         to: 'static_pages#about_us'
  get  '/help',             to: 'static_pages#help'
  get  '/login',            to: 'sessions#new'
  post '/login',            to: 'sessions#create'
  get  '/logout',           to: 'sessions#destroy'
  get  '/signup',           to: 'users#new'
  get  '/listed-companies', to: 'reviews#listed_companies'
  get  '/find-friend',      to: 'friends#index'
  get  '/search-friend',    to: 'friends#search'

  resources :users, only: [:create, :edit, :update] do
    member do
      get 'reviews'
    end
    resources :companies, only: [:index, :new, :create, :edit, :update, :destroy] do
      resources :reviews, only: [:new, :create, :edit, :update, :destroy]
    end

    resources :friends, only: [] do
      post 'send-request', on: :member
    end
  end

  resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :cities,     only: [:index, :new, :create, :edit, :update, :destroy]

  resources :reviews, only: [] do
    get 'recent', on: :collection
  end

  get '/ui(/:action)', controller: 'ui'

end
