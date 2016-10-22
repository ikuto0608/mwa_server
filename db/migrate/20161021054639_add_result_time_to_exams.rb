class AddResultTimeToExams < ActiveRecord::Migration
  def change
    add_column :exams, :result_time, :integer
  end
end
