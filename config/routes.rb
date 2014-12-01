PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  # get '/users/:username', to: 'users#show', as: :user
  # get '/users/:username/edit', to: 'users#edit', as: :edit_user
  # patch '/users/:username', to: 'users#update', as: :update_user

  resources :posts, except: [:destroy] do
    # we don't have new comment, edit page 
    resources :comments, only: [:create] do 
      member do
        post 'vote'
      end
    end

    member do
      post 'vote'
    end
  end # we don't want to pollute the top namespace of URL

  resources :categories, only: [:new, :create, :show]
  resources :users, only: [:show, :create, :edit, :update]
end
