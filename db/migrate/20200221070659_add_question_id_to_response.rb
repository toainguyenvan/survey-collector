class AddQuestionIdToResponse < ActiveRecord::Migration[5.2]
  def change
    add_column :responses, :question_id, :integer
  end
end
