class CreateWants < ActiveRecord::Migration[5.1]
  def change
    create_table :wants do |t|
      t.string :email
      t.text :want
      t.string :company

      t.timestamps
    end
  end
end
