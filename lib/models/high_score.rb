class HighScore < ActiveRecord::Base
    has_many :games
end