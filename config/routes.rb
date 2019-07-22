Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :ideas do
    resources :reviews, only: [:new, :create, :destroy]
    resources :likes, only: [:new, :create, :destroy]
  end

  get '/', {to: 'ideas#index', as: 'root'}
end
