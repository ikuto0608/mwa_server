class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :question
      t.text :question_array
      t.text :index_array_of_answer
      t.integer :user_id
      t.integer :exam_id

      t.timestamps

      t.belongs_to :exam, index: true
    end
  end
end
