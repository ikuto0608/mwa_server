class RenameResultArrayToExam < ActiveRecord::Migration
  def change
    rename_column :exams, :result_hash, :result_array
  end
end
