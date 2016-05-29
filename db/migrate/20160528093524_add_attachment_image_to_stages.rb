class AddAttachmentImageToStages < ActiveRecord::Migration
  def self.up
    change_table :stages do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :stages, :image
  end
end
