class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name
      t.string :web_addr

      t.timestamps null: false
    end
  end
end
