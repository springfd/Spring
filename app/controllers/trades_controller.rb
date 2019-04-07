class TradesController < ApplicationController

  def donate
    #require 'rest-client'
    today = Date.today;
    #validations_result = validations([{type: 'presence', title: '金額', data: params[:amount]}])
    #checkValidations(validations: validations_result, render: 'donation' )
    #@donation = Donation.create(name: "彼得潘", amount: params[:amount], donate_way: GLOBAL_VAR["donate_transfer"], donate_date: today, receipt_title: params[:title], receipt_address: params[:address], phone: params[:phone])
    order_no = generate_order_num()
    parameters =
        '{
        "sender":"rest",
        "ver":"1.0.0",
        "mid":"999812666555180",
        "tid":"T0000000",
        "pay_type":1,
        "tx_type":1,
        "params":
        {
        "layout":"1",
        "order_no":"test12345678",
        "amt":"100",
        "cur":"NTD",
        "order_desc":"測試",
        "capt_flag":"0",
        "result_flag":"1",
        "post_back_url":"https://spring.org.tw/trades/post_back",
        "result_url":"https://spring.org.tw/trades/result",
        }}'
		res = CurbFu.post({:host => 'tspg-t.taishinbank.com.tw/tspgapi/restapi/auth.ashx', :protocol => "https"}, parameters)
		logger.info JSON.parse(res.body)
		logger.info 11111
    #res = RestClient.post("https://tspg-t.taishinbank.com.tw/tspgapi/restapi/auth.ashx" , parameters, :headers => {:content_type => 'json'})
    #redirect_to JSON.parse(res)["params"]["hpp_url"]
  end


  def index

  end

  def post_back
  end

  def result
  end

  private
    def generate_order_num
      order_no = "NO";
      8.times{ order_no  << (48 + rand(9)).chr}
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
