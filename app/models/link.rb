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
class Link < ActiveRecord::Base
  validates :name, :name_en, :web_addr, presence: true
  has_translation :name    
end
