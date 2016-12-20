class AddUserNameToRanks < ActiveRecord::Migration
  def change
    add_column :ranks, :user_name, :string
  end
end
