class AddColumnsToExams < ActiveRecord::Migration
  def change
    add_column :exams, :number_of_answer, :integer
    add_column :exams, :description, :text
  end
end
