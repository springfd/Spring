class Project < ActiveRecord::Base
   has_many :donations
   has_attached_file :pj_attachment,
      :url  => "/assets/pj_attachments/:id/:style/:basename.:extension"
      #:path => ":rails_root/public/assets/pj_attachments/:id/:style/:basename.:extension"
   do_not_validate_attachment_file_type :pj_attachment
   
   has_attached_file :pj_cover,
      :url  => "/assets/pj_covers/:id/:style/:basename.:extension"
      #:path => ":rails_root/public/assets/pj_covers/:id/:style/:basename.:extension"
   do_not_validate_attachment_file_type :pj_cover
   
   validates :name, :kind, :year, :donate_begin_at, :donate_end_at, :exe_desc,  presence: true
   validates :account_begin, :account_end, presence: true , if: "kind==1" #委辦計畫
end
