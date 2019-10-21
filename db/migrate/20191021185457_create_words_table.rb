class CreateWordsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string :name
      t.string :hint
      t.integer :difficulty
    end
  end
end
