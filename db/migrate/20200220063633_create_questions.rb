class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :type
      t.string :prompt
      t.boolean :optional

      t.timestamps
    end
  end
end
