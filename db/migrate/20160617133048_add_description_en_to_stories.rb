class AddDescriptionEnToStories < ActiveRecord::Migration
  def change
    add_column :stories, :description_en, :string
  end
end
