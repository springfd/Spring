class CreateSignReports < ActiveRecord::Migration
  def change
    create_table :sign_reports do |t|
      t.string :title
      t.datetime :year

      t.timestamps null: false
    end
  end
end
