Rails.application.routes.draw do

  resources :profiles
  root 'profiles#scrapping'
  post '/', to: 'profiles#create'

end
