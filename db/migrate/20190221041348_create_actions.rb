class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.string :title
      t.string :location
      t.text :description
      t.date :start_date
      t.date :end_date
      t.references :theme, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
