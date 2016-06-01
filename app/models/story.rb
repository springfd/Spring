class Story < ActiveRecord::Base
  has_many :pictures, :dependent => :destroy
  validates :topic, :description, :news_date, presence: true
end
