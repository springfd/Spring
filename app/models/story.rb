class ActiveRecord::Base
  def self.has_translation(*attributes)    
    attributes.each do |attribute|
      define_method "#{attribute}" do
        if I18n.locale == I18n.default_locale
          self.read_attribute(attribute)
        else
          self.send "#{attribute}_#{I18n.locale}"
        end
      end
    end
  end
end

class Story < ActiveRecord::Base
  has_many :pictures, :dependent => :destroy
  validates :topic, :description, :news_date, presence: true
  has_translation :topic, :description
end
