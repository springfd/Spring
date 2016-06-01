class AddAttachmentPjExpAttachmentToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.attachment :pj_exp_attachment
    end
  end

  def self.down
    remove_attachment :projects, :pj_exp_attachment
  end
end
