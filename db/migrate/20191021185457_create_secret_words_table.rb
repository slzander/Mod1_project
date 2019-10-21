class CreateSecretWordsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :secret_words do |t|
      t.string :word
      t.string :hint
      t.integer :difficulty
    end
  end
end
