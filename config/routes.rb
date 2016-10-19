Rails.application.routes.draw do
  get  'users/setIdentity'

  resources :donation_lists
  resources :special_projects
  resources :downloads
  scope "(:locale)", locale: /en|zh-TW/ do
    resources :sign_reports
    resources :donations
    resources :projects
    resources :stories
    resources :links
    resources :downloaded
    as :user do
        patch '/user/confirmation' => 'users/confirmations#update', :via => :patch, :as => :update_user_confirmation
    end
    devise_for :users, :controllers => { :registrations => "registrations", :confirmations => "users/confirmations", :passwords => 'users/passwords' } # be careful of the order with resources users
    resources :users, only: [:index, :show, :destroy]
    
    post 'projects/checkLogin'
    post 'projects/delete_stage'
    post 'projects/ajax_update'
    
    get  'main/post_back'
    post 'main/result'
    post 'main/post_back'
    post 'main/donation'
    
    
    get  'donation', to: 'main#donation'
  
    get  'main/about'
    get  'main/boardMembers'
    get  'main/meetings' 
    get  'main/contactUs' 
    get  'main/otherLinks'        
    get  'main/news'
    get  'main/donation'
    get  'main/downloaded'
    get  'main/downloadManual' 
    get  'main/downloadBoardLists'  
    get  'main/special'   
    root 'main#about'
  end
end
