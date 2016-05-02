class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.datetime :year
      t.string :name
      t.integer :kind
      t.integer :budget
      t.integer :income
      t.integer :exp_personnel
      t.integer :exp_business
      t.integer :exp_mix
      t.integer :exp_other
      t.string :exe_desc
      t.boolean :donate_flag
      t.string :abbreviation
      t.datetime :account_begin
      t.datetime :account_end
      t.string :account
      t.string :encrypted_password
      t.string :encrypted_password_iv

      t.timestamps null: false
    end
  end
end
