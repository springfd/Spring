class MainController < ApplicationController
  #before_filter :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:post_back, :result]
  def about
    
  end
  
  def news
    
  end
  
  def donation
    if request.post?
      require 'rest-client'
      today = Date.today;
      amount = params[:amount_others].blank? ? ( params.has_key?(:amount) ? params[:amount] : "" ) : params[:amount_others]
      validation_result = [] #initialize
      validations([{type: 'presence', title: '金額', data: amount}], validation_result) 
      if params[:receipt] == "true" # whether validate the receipt form or not
        validations([{type: 'presence', title: '收據抬頭', data: params[:title]}, 
                     {type: 'presence', title: '電話', data: params[:phone]}, 
                     {type: 'presence', title: '地址', data: params[:address]},  
                    ], validation_result)
      end
      checkValidations(validations: validation_result, render: 'donation' )
      @donation = Donation.create(name: "彼得潘", amount: amount, donate_way: GLOBAL_VAR["donate_transfer"], donate_date: today, receipt_title: params[:title], receipt_address: params[:address], phone: params[:phone])
      order_no = generate_order_num()
      @donation.order_num = order_no
      @donation.save!
      parameters = 
          '{
          "sender":"rest",
          "ver":"1.0.0",
          "mid":"999812666555044",
          "tid":"T0000000",
          "pay_type":1,
          "tx_type":1,
          "params":
          {
          "layout":"'+check_device+'",
          "order_no":"'+order_no+'",
          "amt":"'+amount+"00"+'",
          "cur":"NTD",
          "order_desc":"測試 3C 網站購物",
          "capt_flag":"0",
          "result_flag":"1",
          "post_back_url":"http://140.113.151.76:10111/main/post_back",
          "result_url":"https://140.113.151.76:10111/main/result",
          }}'
      res = RestClient.post("https://tspg-t.taishinbank.com.tw/tspgapi/restapi/auth.ashx" , parameters, :headers => {:content_type => 'json'})
      redirect_to JSON.parse(res)["params"]["hpp_url"]
    end
  end   
  
  def post_back
      @donation = Donation.find_by order_num: params[:order_no]
    if params[:ret_code] == "00" 
      @donation.donate = true
      @donation.save
      redirect_to "/main/about", notice: "捐款成功<br>"+ "金額: " + @donation.amount.to_s
    else
      @donation.destroy
      redirect_to "/main/about", notice: "捐款失敗<br>" + params[:ret_msg]
    end
  end
  
  def result
    #if JSON.parse(res)["params"]["ret_code"] == "00" 
    #  @donation = Donation.find_by order_no: JSON.parse(res)["params"]["order_no"]
    #  @donation.donate = true
    #  @donate.save
    #end
  end
  
  private
    def generate_order_num
      order_no = "NO"; 
      8.times{ order_no  << (48 + rand(9)).chr}
      order_no << "_"+@donation.id.to_s
      return order_no
    end
    
    def check_device
      if mobile_device?
        return "2" # 2 is layout params for mobile
      else
        return "1" # 1 is layout params for general web page
      end
    end
end
