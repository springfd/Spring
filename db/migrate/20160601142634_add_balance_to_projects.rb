class AddBalanceToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :balance, :integer
  end
end
