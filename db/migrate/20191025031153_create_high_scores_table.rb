class CreateHighScoresTable < ActiveRecord::Migration[6.0]
  def change
    create_table :high_scores do |t|
      t.string :user_name
      t.float :score
    end
  end
end
