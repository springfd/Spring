class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :require_no_authentication, only: [:new, :create]# you can go to sign up page when you try to sign up another user 

  def new
    super
  end
  
  def create
    super
  end
  
  def after_update_path_for(resource)
    case resource
    when :user, User
      resource.teacher? ? another_path : "/users"
    else
      super
    end
  end
end