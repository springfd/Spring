class Donation < ActiveRecord::Base
  validates :name, :amount, :donate_way, :donate_date, presence: true
end