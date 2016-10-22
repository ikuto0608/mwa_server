class AddVolatileJsonToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :volatile_json, :text
  end
end
