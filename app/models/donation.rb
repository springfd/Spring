class Donation < ActiveRecord::Base
  belongs_to :project
  
  validates :name, :amount, :donate_way, :donate_date, presence: true
end
