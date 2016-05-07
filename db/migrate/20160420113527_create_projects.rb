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
      t.text :exe_desc
      t.text :description
      t.string :abbreviation
      t.datetime :donate_begin_at
      t.datetime :donate_end_at
      t.datetime :account_begin
      t.datetime :account_end
      t.string :account
      t.string :password

      t.timestamps null: false
    end
  end
end
