class SignReport < ActiveRecord::Base
  has_attached_file :sr_attachment,
      :url  => "/assets/sr_attachments/:id/:style/:basename.:extension"
      #:path => ":rails_root/public/assets/sr_attachments/:id/:style/:basename.:extension"
   do_not_validate_attachment_file_type :sr_attachment
   
   validates :title, :year,  presence: true
end
