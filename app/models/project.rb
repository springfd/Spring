class Project < ActiveRecord::Base
  attr_encrypted :password, key: 'This is a key that is 256 bits!!'
  
   has_attached_file :pj_attachment,
      :url  => "/assets/pj_attachments/:id/:style/:basename.:extension",
      :path => ":rails_root/public/assets/pj_attachments/:id/:style/:basename.:extension"
   do_not_validate_attachment_file_type :pj_attachment
   
   validates :name, :kind, :year,  presence: true, if: "kind == 0"#self project
   validates :name, :kind, :year, presence: true, if: "kind == 1"#delegate project
end
