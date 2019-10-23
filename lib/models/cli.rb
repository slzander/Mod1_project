require 'tty-prompt'


class Cli
    attr_accessor :user, :game

    @@guess = []

    def initialize(user, game)
        @user = user
        @game = game
    end

    def start
        puts "Welcome to CHOMPMAN"
        puts "What's your name?"
        user_name = gets.chomp
        self.user = User.create(name: user_name)
        puts "Hi #{user.name}!"
        wrong_letters = []
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

        response = prompt.select("Choose your difficulty", %w(Easy Medium Hard))
        if response == "Easy"
            chosen_word = easy_array.sample
        elsif response == "Medium"
            chosen_word = medium.sample
        else
            chosen_word = hard.sample
        end
        self.game = Game.create(user: self.user, secret_word: chosen_word, incorrect_guesses: 0, win?: false, score: 0)
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
        end
    end

    def split_word
        SecretWord.find(game.secret_word_id).word.split("")
    end

    def blanks
        split_word.map{|letter| letter = "_ "}
    end
 
    def display_blanks
        print blanks.join
        puts ""
    end

    def add_correct_guess(letter_guess)
        i = 0
        if @@guess == []
            @@guess = blanks
        end
        
        while i < split_word.length
            if split_word[i] == letter_guess
                @@guess[i] = letter_guess
            end
            i += 1
        end
        print @@guess
        puts ""
    end
    
    def guess_a_letter
        response = gets.chomp.downcase
        possible_letters = ('a'..'z').to_a
        if possible_letters.include?(response)
            if split_word.include?(response)
                add_correct_guess(response)
                win_game?
            else
                self.game.incorrect_guesses += 1 
                add_incorrect_guess(response)
                end_game?
            end
        elsif response == '*'
            show_hint
            guess_a_letter
        else
            puts 'That is not a valid input! Please type any single letter or *'
            guess_a_letter
        end
    end
    
    def display_game
        show_shark
        display_blanks
        puts 'Guess a letter! If you need help, type *, but it will cost you!'
        print SecretWord.find(game.secret_word_id).word.split("") #get rid of this later! just so that we can see the word for now...
        puts ""
        guess_a_letter
    end

    def play_game
        show_shark
        display_incorrect_guesses
        puts "Guess again!"
        guess_a_letter
    end

    def show_hint
        self.game.incorrect_guesses += 1
        puts "The definition of this word is: #{self.game.secret_word.hint}"
    end

    def display_incorrect_guesses
        puts "Incorrect letters: #{}"
    end

    def add_incorrect_guess(response)
        wrong_letters << response
    end

    def end_game?
        if self.game.incorrect_guesses == 6
            puts "you lost!"
        end
    end
    
    def win_game?
        if @@guess.include?("_ ")
            play_game
        else
            puts "you won!"
        end
    end
end