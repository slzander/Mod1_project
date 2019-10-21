class CreateGamesTable < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.references :user, foreign_key: true
      t.references :secret_word, foreign_key: true
      t.integer :incorrect_guesses
      t.boolean :win?
      t.float :score
    end
  end
end
