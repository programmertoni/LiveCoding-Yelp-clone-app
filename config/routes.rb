Rails.application.routes.draw do
  root 'reviews#recent'

  get  '/about-us', to: 'static_pages#about_us'
  get  '/help',     to: 'static_pages#help'
  get  '/login',    to: 'sessions#new'
  post '/login',    to: 'sessions#create'
  get  '/logout',   to: 'sessions#destroy'
  get  '/signup',   to: 'users#new'

  resources :users,     only: [:create, :edit, :update] do
    resources :companies, only: [:new, :create, :edit, :update, :index, :destroy]
  end

  resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :cities,     only: [:index, :new, :create, :edit, :update, :destroy]

  resources :reviews, only: [] do
    get 'recent', on: :collection
  end

  get '/ui(/:action)', controller: 'ui'

end
