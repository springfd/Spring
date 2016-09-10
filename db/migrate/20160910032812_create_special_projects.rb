class CreateSpecialProjects < ActiveRecord::Migration
  def change
    create_table :special_projects do |t|
      t.string :title
      t.string :title_enlarge
      t.string :link
      t.text :description

      t.timestamps null: false
    end
  end
end
