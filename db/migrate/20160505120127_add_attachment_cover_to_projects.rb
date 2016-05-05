class AddAttachmentCoverToProjects < ActiveRecord::Migration
  def self.up
    change_table :projects do |t|
      t.attachment :pj_cover
    end
  end

  def self.down
    remove_attachment :projects, :pj_cover
  end
end
