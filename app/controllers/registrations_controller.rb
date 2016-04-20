class RegistrationsController < Devise::RegistrationsController

  skip_before_filter :require_no_authentication, only: [:new]

  def new
    super
  end
  
  #def edit
  #  super
  #end

  #def create
  #  super
  #end
  
end