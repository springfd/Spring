class Project < ActiveRecord::Base
   has_attached_file :pj_attachment,
      :url  => "/assets/pj_attachments/:id/:style/:basename.:extension",
      :path => ":rails_root/public/assets/pj_attachments/:id/:style/:basename.:extension"
   do_not_validate_attachment_file_type :pj_attachment
end
