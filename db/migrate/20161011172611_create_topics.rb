class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :question
      t.text :questionArray
      t.text :indexArrayOfAnswer
      t.integer :userId
      t.integer :examId

      t.timestamps

      t.belongs_to :exam, index: true
    end
  end
end
