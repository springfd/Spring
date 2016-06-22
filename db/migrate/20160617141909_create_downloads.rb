class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
