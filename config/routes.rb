Rails.application.routes.draw do
  get '/', to: 'home#index', as: 'root'

  resources :posts
  resources :projects, except: [:show]

  get '/posts/:id/tags', to: 'posts#tags'
  get '/tags', to: 'posts#all_tags'
end
