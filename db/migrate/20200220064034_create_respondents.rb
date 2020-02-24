class CreateRespondents < ActiveRecord::Migration[5.2]
  def change
    create_table :respondents do |t|
      t.string :identifier
      t.string :gender
      t.string :department

      t.timestamps
    end
  end
end
