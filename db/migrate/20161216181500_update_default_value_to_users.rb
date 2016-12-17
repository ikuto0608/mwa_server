class UpdateDefaultValueToUsers < ActiveRecord::Migration
  def change
    change_column :users, :property_json, :text, :default => "{}"
  end
end
