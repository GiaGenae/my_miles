class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.string :date
      t.decimal :distance
      t.decimal :duration
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
