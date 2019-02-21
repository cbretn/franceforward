Rails.application.routes.draw do

  get 'messages/index'
  get 'messages/new'
  get 'messages/create'
  get 'conversations/index'
  get 'conversations/create'
  root to: 'pages#home'

  get 'home', to: 'pages#home', as: :home
  get 'about', to: 'pages#about', as: :about
  get 'contact', to: 'pages#contact', as: :contact

  devise_for :users
  resources :conversations do
    resources :messages
  end

  resources :categories, only: [:index, :show] do
    resources :themes, only: [:index, :show] do
      resource :description, only: [:show]
      resources :discussions
      resources :actions do
        resources :action_participations
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
