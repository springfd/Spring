class AddNewsDateToStories < ActiveRecord::Migration
  def change
    add_column :stories, :news_date, :datetime
  end
end
