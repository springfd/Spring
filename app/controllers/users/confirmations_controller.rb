class Users::ConfirmationsController < Devise::ConfirmationsController
  skip_before_filter :require_no_authentication
  skip_before_filter :authenticate_user!
  # GET /resource/confirmation/new
  def new
    super
  end

  # POST /resource/confirmation
  def create
    super
  end
   # PUT /resource/confirmation
  def update
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        @confirmable.attempt_set_password(params[:user])
        if @confirmable.valid?
          do_confirm
        else
          do_show
          @confirmable.errors.clear #so that we wont render :new
        end
      else
        @confirmable.errors.add(:email, :password_already_set)
      end
    end

    if !@confirmable.errors.empty?
      self.resource = @confirmable
      render 'devise/confirmations/new' #Change this if you don't have the views on default path
    end
  end
  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    with_unconfirmed_confirmable do
      if @confirmable.has_no_password?
        do_show
      else
        do_confirm
      end
    end
    unless @confirmable.errors.empty?
      self.resource = @confirmable
      render 'devise/confirmations/new' #Change this if you don't have the views on default path 
    end
  end

  protected

  def with_unconfirmed_confirmable
    original_token = params[:confirmation_token]
    @confirmation_token = original_token
    #confirmation_token = Devise.token_generator.digest(User, :confirmation_token, original_token)
    @confirmable = User.find_or_initialize_with_error_by(:confirmation_token, original_token)
    if !@confirmable.new_record?
      @confirmable.only_if_unconfirmed {yield}
    end
  end

  def do_show
    original_token = params[:confirmation_token]
    @confirmation_token = original_token
    #confirmation_token = Devise.token_generator.digest(User, :confirmation_token, original_token)
    temp_errors = @confirmable.errors.to_hash(true) #keep error message
    @confirmable = User.find_or_initialize_with_error_by(:confirmation_token, original_token)
    logger.info @confirmable.errors.to_hash(true) #assign error message
    temp_errors.each do |attribute, error|
      @confirmable.errors.set(attribute, error)
    end
    @requires_password = true
    self.resource = @confirmable
    render 'devise/confirmations/show' #Change this if you don't have the views on default path
  end
  
  def do_confirm
    @confirmable.confirm
    set_flash_message :notice, :confirmed
    sign_in_and_redirect(resource_name, @confirmable)
  end

  # The path used after resending confirmation instructions.
   def after_resending_confirmation_instructions_path_for(resource_name)
     if signed_in?
      new_user_confirmation_path
    else
      new_session_path(resource_name)
    end
   end

  # The path used after confirmation.
  # def after_confirmation_path_for(resource_name, resource)
  #   super(resource_name, resource)
  # end
end
