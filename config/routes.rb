Rails.application.routes.draw do
  get 'sessions/new'

  resources :members
  resources :cars
  resources :histories
  resources :notifications
  resources :suggestions

  get 'welcome/index'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  post '/search' => 'cars#search'
  get '/reserve' => 'cars#reserve'
  get '/carhistory' => 'histories#carhistory'
  post '/checkout' => 'cars#checkout'
  post '/checkoutsubmit' => 'cars#checkoutsubmit'
  post '/reservesubmit' => 'cars#reservesubmit'
  root :to => redirect('/welcome/index')
  post '/returncar' => 'cars#returncar'
  get    '/login_admin',   to: 'sessions#new_admin'
  post '/login_admin' => 'sessions#createadmin'
  post '/createad' => 'members#createad'
  post '/createsys' => 'members#createsys'
  get    '/sys_admin_login',   to: 'members#new_sys'
  post '/createnotify' => 'notifications#createnotify'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
