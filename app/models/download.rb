class Download < ActiveRecord::Base
  has_attached_file :file_at,
      :url  => "/assets/file_ats/:id/:style/:basename.:extension"
   do_not_validate_attachment_file_type :file_at
  validates :title, presence: true
end
