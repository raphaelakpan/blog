Rails.application.routes.draw do
  get '/', to: 'home#index', as: 'root'

  resources :posts
  resources :projects, except: [:show]
end
