PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  resources :posts, except: [:destroy] do 
    resources :comments, only: [:create] # we don't have new comment, edit page
  end # we don't want to pollute the top namespace of URL

  resources :categories, only: [:new, :create, :show]
end
