Rails.application.routes.draw do

  
  resources :sign_reports
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
  
  get  'main/result'
  get  'main/post_back'
  post 'main/result'
  post 'main/post_back'
  post 'main/donation'
  
  

  get  'main/about'
  get  'main/news'
  get  'main/donation'  
  root 'main#about'

  
end
