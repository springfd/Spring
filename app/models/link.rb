class Link < ActiveRecord::Base
  validates :name, :web_addr, presence: true
end
