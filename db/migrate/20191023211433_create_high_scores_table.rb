class CreateHighScoresTable < ActiveRecord::Migration[6.0]
  def change
    create_table :high_scores do |t|
      t.references :user, foreign_key: true
      t.references :game, foreign_key: true
      t.string :initials
    end
  end
end
