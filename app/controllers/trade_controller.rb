class TradeController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:post_back]
  
  def donate
    
  end  
    
    
  def index
    require 'rest-client'
    params = 
        '{
        "sender":"rest",
        "ver":"1.0.0",
        "mid":"999812666555044",
        "tid":"T0000000",
        "pay_type":1,
        "tx_type":1,
        "params":
        {
        "layout":"1",
        "order_no":"NO01234562",
        "amt":"120000",
        "cur":"NTD",
        "order_desc":"測試 3C 網站購物",
        "capt_flag":"0",
        "result_flag":"1",
        "post_back_url":"http://140.113.151.76:10111/trade/post_back",
        "result_url":"https://140.113.151.76:10111/trade/result"
        }}'
    #res = RestClient.post("https://tspg-t.taishinbank.com.tw/tspgapi/restapi/auth.ashx" , params, :headers => {:content_type => 'json'})
    #redirect_to JSON.parse(res)["params"]["hpp_url"]
  end
  def post_back
    logger.info "xxxxxxxxxxxxxxxxxxxxxxxx"
  end
  def result
    logger.info "xxxxxxxxxxxxxxxxxxxxxxxx"
  end
end
