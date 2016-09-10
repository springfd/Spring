class SpecialProject < ActiveRecord::Base
   validates :title, :title_enlarge, :description, :link,  presence: true
	
end
