class AddAttachmentFileToSignReports < ActiveRecord::Migration
  def self.up
    change_table :sign_reports do |t|
      t.attachment :sr_attachment
    end
  end

  def self.down
    remove_attachment :sign_reports, :sr_attachment
  end
end
