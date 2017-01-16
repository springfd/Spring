class Donation < ActiveRecord::Base
  belongs_to :project
  
  validates :amount, :donate_way, :donate_date, :project_id, presence: true
  validates :order_num, uniqueness: true, on: :update
  validates :order_num, presence: true, on: :update
end
