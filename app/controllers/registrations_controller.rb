class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, only: [:new, :create]# you can go to sign up page when you try to sign up another user 

  def new
    super
  end
  
  def create
    super
  end
  
end