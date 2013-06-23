Blog::Application.routes.draw do
  devise_for :users

  resources :users, path: "u", only: [:show] do
    member do
      post "follow" => "users#follow"
      delete "follow" => "users#unfollow"
    end
    resources :posts, path: "p", only: [:show]
  end

  resources :posts, path: "p", only: [:new, :create, :edit, :update, :destroy]

  root :to => "index#index"
end
