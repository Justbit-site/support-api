class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :email
      t.string :company
      t.string :website

      t.timestamps
    end
  end
end
