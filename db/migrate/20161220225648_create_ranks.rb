class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.integer :user_id
      t.integer :exam_id
      t.integer :number_of_perfect_in_a_row
      t.integer :number_of_current_perfect_in_a_row
      t.float :average_perfect_record_time

      t.timestamps

      t.index :user_id
      t.index :exam_id
    end
  end
end
