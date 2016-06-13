class AddHolderAndPhoneAndEmailToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :holder, :string
    add_column :projects, :phone, :string
    add_column :projects, :email, :string
  end
end
