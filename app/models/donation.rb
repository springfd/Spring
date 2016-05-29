class Donation < ActiveRecord::Base
  belongs_to :project
  
  validates :amount, :donate_way, :donate_date, presence: true
end
