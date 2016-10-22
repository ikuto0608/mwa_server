class AddVolatileJsonToExams < ActiveRecord::Migration
  def change
    add_column :exams, :volatile_json, :text
  end
end
