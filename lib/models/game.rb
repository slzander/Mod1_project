class Game < ActiveRecord::Base
    belongs_to :user
    belongs_to :secret_word
end