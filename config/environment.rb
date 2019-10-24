require 'sinatra/activerecord'
require 'sqlite3'
require 'require_all'
# require 'paint'
require 'pry'


require_all 'lib'
ActiveRecord::Base.logger = nil



def play_or_add_word
    prompt = TTY::Prompt.new
    response = prompt.select("      Would you like to play or add a new word to the game?", 
    ["       Play", "       Add a new word"])
    if response == "       Play"
        difficulty
    else
        add_word_to_game
    end
end

def difficulty
    system('clear')
    puts chompman_title
    #  ... etc ...
end


def add_word_to_game
    system('clear')
    # puts chompman_title
    puts "      Type the word you would like to add:"
    puts ""
    new_word = gets.chomp
    puts ""
    puts "      Type the definition for this word:"
    puts ""
    new_definition = gets.chomp
    puts ""
    new_difficulty = prompt.select("      Rate the difficulty of the word:", ["       Easy", "       Medium", "       Hard"])
    if response == "       Easy"
        new_difficulty = 1
    elsif response == "       Medium"
        new_difficulty = 2
    else
        new_difficulty = 3
    end
    SecretWord.create(word: new_word, hint: new_definition, difficulty: new_difficulty)
    puts ""
    puts "      Thanks for adding a new word to the game!"
    play_or_add_word
end




# binding.pry
