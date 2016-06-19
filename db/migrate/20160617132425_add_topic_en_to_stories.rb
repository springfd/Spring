class AddTopicEnToStories < ActiveRecord::Migration
  def change
    add_column :stories, :topic_en, :string
  end
end
