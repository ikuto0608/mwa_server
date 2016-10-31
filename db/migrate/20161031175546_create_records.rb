class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.references :user, index: true
      t.references :exam, index: true

      t.integer  :score
      t.integer  :record_time
      t.string   :topic_ids
      t.string   :wrong_answer_topic_ids

      t.timestamps
    end
  end
end
