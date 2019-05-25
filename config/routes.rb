Rails.application.routes.draw do

  root to: 'pages#home'

  get 'home', to: 'pages#home', as: :home
  get 'about', to: 'pages#about', as: :about
  get 'contact', to: 'pages#contact', as: :contact

  devise_for :users
  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  resources :categories, only: [:index, :show] do
    resources :themes, only: [:index, :show] do
      resource :description, only: [:show]
      resources :discussions
      resources :actions do
        resources :action_participations, only: [:index, :create, :destroy]
      end
    end
  end

  get 'themes', to: 'themes#all', as: :themes

end
