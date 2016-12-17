class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :property_json, :text
  end
end
