class ChangeArrayColumnFromRecord < ActiveRecord::Migration
  def change
    remove_column :records, :topic_ids, :string
    remove_column :records, :wrong_answer_topic_ids, :string

    add_column :records, :topic_ids, :text
    add_column :records, :wrong_answer_topic_ids, :text
  end
end
