module DonationsHelper
  def donateWayOptions
    [['電匯', GLOBAL_VAR['donate_transfer']], 
     ['支票', GLOBAL_VAR['donate_check']], 
     ['現金', GLOBAL_VAR['donate_cash']]]
  end  
end
