class CreateActionParticipations < ActiveRecord::Migration[5.2]
  def change
    create_table :action_participations do |t|
      t.references :action, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
