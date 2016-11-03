class AddEnToLinksAndDownloads < ActiveRecord::Migration
  def change
    add_column :links, :name_en, :string
    add_column :downloads, :title_en, :string
    
  end
end
