class CreateTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :types do |t|
      t.string :platform
      t.text :other
      t.references :want, foreign_key: true

      t.timestamps
    end
  end
end
