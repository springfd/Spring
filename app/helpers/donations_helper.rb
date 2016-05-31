module DonationsHelper
  def donateWayOptions
    [['電匯', GLOBAL_VAR['donate_transfer']], 
     ['線上刷卡', GLOBAL_VAR['donate_credit']], 
     ['其他', GLOBAL_VAR['donate_others']]]
  end  
end
