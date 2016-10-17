class AddResultHashToExam < ActiveRecord::Migration
  def change
    add_column :exams, :result_hash, :text
  end
end
