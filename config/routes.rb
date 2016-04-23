Rails.application.routes.draw do

  resources :donations
  resources :projects
  resources :stories
  resources :links
  as :user do
      patch '/user/confirmation' => 'users/confirmations#update', :via => :patch, :as => :update_user_confirmation
  end
  devise_for :users, :controllers => { :confirmations => "users/confirmations", :registrations => "registrations" } # be careful of the order with resources users
  resources :users, only: [:index, :show, :destroy]
  get 'trade/post_back'
  get 'trade/result'
  post 'trade/result'
  post 'trade/post_back'



  root 'main#index'
  
  
end
