Rails.application.routes.draw do

  get 'description/show'
  devise_for :users
  root to: 'pages#home'

  get 'home', to: 'pages#home', as: :home
  get 'about', to: 'pages#about', as: :about
  get 'contact', to: 'pages#contact', as: :contact

  resources :categories, only: [:index, :show] do
    resources :themes, only: [:index, :show] do
      resource :description, only: [:show]
      resources :discusions
      resources :actions do
        resources :action_participations
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
