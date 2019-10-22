require 'tty-prompt'


class Cli
    attr_accessor :user, :game

    def initialize(user, game)
        @user = user
        @game = game
    end

    def start
        puts "Welcome to the game"
        puts "What's your name?"
        user_name = gets.chomp
        self.user = User.create(name: user_name)
        puts "Hi #{user.name}!"
        difficulty
        display_game
    end

    # def play_or_add
    #     would you like to play or add a new word?
    # end

    def difficulty
        prompt = TTY::Prompt.new
        easy_array = SecretWord.all.select {|word| word.difficulty == 1}
        medium = SecretWord.all.select {|word| word.difficulty == 2}
        hard = SecretWord.all.select {|word| word.difficulty == 3}

        response = prompt.select("Choose difficulty", %w(Easy Medium Hard))
        if response == "Easy"
            chosen_word = easy_array.sample
        elsif response == "Medium"
            chosen_word = medium.sample
        else
            chosen_word = hard.sample
        end
        self.game = Game.create(user: self.user, secret_word: chosen_word, incorrect_guesses: 0, win?: false, score: 0)
    end

    def display_game
        puts "hooray! let's play"
    end



end