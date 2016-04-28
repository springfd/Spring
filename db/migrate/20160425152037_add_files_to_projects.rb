class AddFilesToProjects < ActiveRecord::Migration
  def up
    add_attachment :projects, :pj_attachment
  end

  def down
    remove_attachment :projects, :pj_attachment
  end
end
