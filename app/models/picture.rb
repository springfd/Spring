class Picture < ActiveRecord::Base
  belongs_to :story
  has_attached_file :image, :styles => { :small => "150x150>" },
                  :url  => "/assets/pictures/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/pictures/:id/:style/:basename.:extension"
  do_not_validate_attachment_file_type :image
end
