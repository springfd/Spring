Rails.application.routes.draw do

  resources :donations
  resources :projects
  resources :stories
  resources :links
  as :user do
      patch '/user/confirmation' => 'users/confirmations#update', :via => :patch, :as => :update_user_confirmation
  end
  devise_for :users, :controllers => { :registrations => "registrations", :confirmations => "users/confirmations" } # be careful of the order with resources users
  resources :users, only: [:index, :show, :destroy]
  
  post 'projects/checkLogin'
  
  get  'trades/result'
  get  'trades/post_back'
  post 'trades/result'
  post 'trades/post_back'
  post 'trades/donate'

  get  'main/about'
  get  'main/news'
  get  'main/donation'  
  root 'main#about'

  get '/fKF2erXB', :to => redirect('/fKF2erXB.html')  
  
end
