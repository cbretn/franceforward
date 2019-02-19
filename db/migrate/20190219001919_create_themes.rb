class CreateThemes < ActiveRecord::Migration[5.2]
  def change
    create_table :themes do |t|
      t.references :category, foreign_key: true
      t.string :name
      t.string :photo

      t.timestamps
    end
  end
end
