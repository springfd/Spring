class DonationList < ActiveRecord::Base
  has_attached_file :dl_attachment,
      :url  => "/assets/dl_attachments/:id/:style/:basename.:extension"
      #:path => ":rails_root/public/assets/sr_attachments/:id/:style/:basename.:extension"
   do_not_validate_attachment_file_type :dl_attachment
   
   validates :title, :year,  presence: true	
end
