class AddLastYearAccountingToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :last_year_exp, :integer
    add_column :projects, :last_year_balance, :integer
  end
end
