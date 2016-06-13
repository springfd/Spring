class AddAttachmentPjDonationAttachmentToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.attachment :pj_donation_attachment
    end
  end

  def self.down
    remove_attachment :projects, :pj_donation_attachment
  end
end
