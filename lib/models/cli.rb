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

    def show_shark
        guesses = self.game.incorrect_guesses
            if guesses == 0
                puts '﹏Λ﹏﹏﹏﹏﹏﹏\O/'
            elsif guesses == 1
                puts '﹏﹏Λ﹏﹏﹏﹏﹏\O/'
            elsif guesses == 2
                puts '﹏﹏﹏Λ﹏﹏﹏﹏\O/'
            elsif guesses == 3
                puts '﹏﹏﹏﹏Λ﹏﹏﹏\O/'
            elsif guesses == 4
                puts '﹏﹏﹏﹏﹏Λ﹏﹏\O/'
            elsif guesses == 5
                puts '﹏﹏﹏﹏﹏﹏Λ﹏\O/'
            else
                game_over
        end
    end

    def game_over
        puts 'good-bye'                 
    end


    def show_blanks
        current_word_split = SecretWord.find(game.secret_word_id).word.split("")
        i = current_word_split.length
        while i > 0 do 
            print "___  "
            i -= 1
        end
        puts ""
    end

    def guess_a_letter
        response = gets.chomp.downcase
        possible_letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
        if possible_letters.include?(response)
            puts 'hooray!'

            
        elsif response == '*'
            # show_hint method
        else
            puts 'That is not a valid input! Please type any single letter or *'
            guess_a_letter
        end
    end

    def display_game
        show_blanks
        puts 'Guess a letter! If you need help, type *, but it will cost you!'
        guess_a_letter
        # binding.pry

    end
end