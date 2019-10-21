class User < ActiveRecord::Base
    has_many :games
    has_many :secret_words, through: :games
end