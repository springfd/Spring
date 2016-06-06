class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :set_locale
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
      when 'date_range'
        unless (d[:from].to_date..d[:to].to_date).include?(Date.today)
          validation_result.push({type: 'date_range', message: '今天無法捐款<br>' + d[:title] + ': ' + d[:from].strftime('%Y-%m-%d').to_s + '~' +d[:to].strftime('%Y-%m-%d').to_s})
        end
      end
    end       
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
  
  def default_url_options(options={})#to hide the default locale in url
    { :locale => ((I18n.locale == I18n.default_locale) ? nil : I18n.locale) }
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
    
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
      Rails.application.routes.default_url_options[:locale]= I18n.locale #don't have to add every params locale after changing the language
    end
end
