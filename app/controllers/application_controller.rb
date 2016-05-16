class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from Validations::Failed, with: :validationsHandler
  rescue_from Validations::FailedRemote, with: :validationsRemoteHandler  
  
  def validations(data, validation_result)
    data.each do |d|
      case d[:type]
      when 'presence'     
        if d[:data].blank?
          validation_result.push({type: 'presence', message: '請填寫 '+d[:title]})
        end  
      end
    end       
    logger.info validation_result  
  end
  
  def checkValidations(hash={})
    unless hash[:validations].count==0  
      if request.xhr? 
        raise Validations::FailedRemote
      else        
        raise Validations::Failed.new(errors: hash[:validations], render: hash[:render])
      end   
    end
  end  
  
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  
  private
    def validationsHandler(exception)  
      flash[:error]=""
      exception.args[:errors].each do |e|
        flash.now[:error]=flash.now[:error]+e[:message]+'<br>'
      end
      
      render exception.args[:render]
    end
  
    def validationsRemoteHandler(exception)        
      render json: {success: false, message: exception.message }  
    end    
end
