class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.text :description
      t.string :topic
      t.string :video_url

      t.timestamps null: false
    end
  end
end
