class AddRespondentIdToSubmission < ActiveRecord::Migration[5.2]
  def change
    add_column :submissions, :respondent_id, :integer
  end
end
