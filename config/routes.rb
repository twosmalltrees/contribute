Rails.application.routes.draw do

  devise_for :host_users, controllers: { sessions: "host_users/sessions",
                                         registrations: "host_users/registrations",
                                         confirmations: "host_users/confirmations",
                                         mailers: "host_users/mailers",
                                         passwords: "host_users/passwords"}

  root to: 'static_pages#home'
  get '/about', to: 'static_pages#about', as: 'about'
  get '/sign_in_prompt', to: 'static_pages#sign_in_prompt', as: 'sign_in_prompt'
  get '/sign_in', to: 'sessions#new', as: 'contributor_sign_in'
  post '/sign_in', to: 'sessions#create', as: 'new_contributor_session'
  get '/request_submit_permission', to: 'comments#request_submit_permission'
  post '/remote_sign_in', to: 'sessions#create_remote'
  delete '/remote_sign_in', to: 'sessions#destroy_remote'
  get '/remote_current_contributor', to: 'sessions#remote_current_contributor'
  delete '/sign_in', to: 'sessions#destroy', as: 'destroy_contributor_session'

  resources :comments

  resources :forums do
    resources :discussions
  end

  resources :contributors, only: [:new, :create]

end
