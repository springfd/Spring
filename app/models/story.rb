class Story < ActiveRecord::Base
  has_many :pictures, :dependent => :destroy
  validates :topic, :description, presence: true
end
