Rails.application.routes.draw do
  get "comments/create"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "posts#index"
  devise_for :users
  resources :users do
    member do
      post "follow", to: "follow_requests#follow"
      post "accept", to: "follow_requests#accept"
      post "decline", to: "follow_requests#decline"
      delete "unfollow", to: "follow_requests#unfollow"
      delete "remove_follower", to: "follow_requests#remove_follower"
      delete "cancel_request", to: "follow_requests#cancel_request"
    end
    member do
      get "followers", to: "users#followers"
      get "following", to: "users#following"
    end
  end

  resources :posts do
    member do
      post "like", to: "likes#like"
      delete "unlike", to: "likes#unlike"
    end
    resources :comments, only: [ :create ]
  end
end
