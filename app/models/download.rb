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
class Download < ActiveRecord::Base
  has_attached_file :file_at,
      :url  => "/assets/file_ats/:id/:style/:basename.:extension"
   do_not_validate_attachment_file_type :file_at
  validates :title, :title_en, presence: true
  has_translation :title  
end
