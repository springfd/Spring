class CreateDonationLists < ActiveRecord::Migration
  def change
    create_table :donation_lists do |t|
      t.string :title
      t.datetime :year
      t.attachment :dl_attachment

      t.timestamps null: false
    end
  end
end
