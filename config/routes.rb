# frozen_string_literal: true

Rails.application.routes.draw do
  resources :profiles
  root 'profiles#scrapping'
  post '/', to: 'profiles#create'
  delete 'profiles/:id(.:format)', to: 'profiles#destroy'
end
