class AddAttachmentFileAtToDownloads < ActiveRecord::Migration
  def self.up
    change_table :downloads do |t|
      t.attachment :file_at
    end
  end

  def self.down
    remove_attachment :downloads, :file_at
  end
end
