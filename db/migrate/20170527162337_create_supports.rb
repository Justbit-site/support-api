class CreateSupports < ActiveRecord::Migration[5.1]
  def change
    create_table :supports do |t|
      t.string :type
      t.text :description
      t.references :question, foreign_key: true

      t.timestamps
    end
  end
end
