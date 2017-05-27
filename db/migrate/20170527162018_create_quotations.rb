class CreateQuotations < ActiveRecord::Migration[5.1]
  def change
    create_table :quotations do |t|
      t.string :type
      t.text :description
      t.float :budget
      t.text :business_description
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
