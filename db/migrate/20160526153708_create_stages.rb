class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.integer :project_id
      t.string :title
      t.datetime :stageDate
      t.text :description
      t.string :video_url
    end
  end
end
