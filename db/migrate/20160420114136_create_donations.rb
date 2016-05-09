class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :name
      t.integer :amount
      t.integer :donate_way
      t.datetime :donate_date
      t.string :receipt_title
      t.string :receipt_address
      t.string :phone
      t.string :email

      t.timestamps null: false
    end
  end
end
