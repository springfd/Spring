class Donation < ActiveRecord::Base
  belongs_to :project
  
  validates :amount, :donate_way, :donate_date, :project_id, presence: true
end
