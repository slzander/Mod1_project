class CreateGamesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.references :user, foreign_key: true
      t.references :secret_word, foreign_key: true
    end
  end
end
