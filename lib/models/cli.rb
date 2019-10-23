require 'tty-prompt'


class Cli
    attr_accessor :user, :game

    @@guess = []
    @@incorrect_letters = []


    def initialize(user, game)
        @user = user
        @game = game
    end

    def start
        system('clear')
        puts shark_eating_swimmer_sequence
        puts "      What's your name?"
        print "      "
        user_name = gets.chomp
        system('clear')
        self.user = User.create(name: user_name)
        puts chompman_title
        puts "      Hi #{user.name}!"
        puts ""
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
        response = prompt.select("      Choose your difficulty", ["     Easy", "     Medium", "     Hard"])
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
                puts approaching_shark_0
            elsif guesses == 1
                puts approaching_shark_1
            elsif guesses == 2
                puts approaching_shark_2
            elsif guesses == 3
                puts approaching_shark_3
            elsif guesses == 4
                puts approaching_shark_4
            elsif guesses == 5
                puts approaching_shark_5
        end
    end

    def split_word
        SecretWord.find(game.secret_word_id).word.split("")
    end

    def blanks
        split_word.map{|letter| letter = "_ "}
    end
 
    def display_blanks
        print "         #{blanks.join}"
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
    end

    def guess_a_letter
        response = gets.chomp.downcase
        system('clear')
        possible_letters = ('a'..'z').to_a
        if possible_letters.include?(response) && @@guess.exclude?(response)
            if split_word.include?(response)
                add_correct_guess(response)
                win_game?
            elsif @@incorrect_letters.include?(response)
                already_guessed_correct_letter
                # puts '      You must really want to be shark food - you already guessed that letter!'
                # self.game.incorrect_guesses += 1
                # end_game?
            else    
                self.game.incorrect_guesses += 1 
                 @@incorrect_letters << response 
                end_game?
            end
        elsif response == '*'
            show_hint
            guess_a_letter
        elsif @@guess.include?(response) #|| @@incorrect_letters.include?(response)
            already_guessed_incorrect_letter
            # puts '      You already guessed that letter! Guess again'
            # guess_a_letter
        else
            puts '      That is not a valid input! Please type any single letter or *'
            guess_a_letter
        end
         print @@guess.join
        puts ""
        guess_a_letter
    end


    def incorrect_letters_string
        @@incorrect_letters.reduce do |sum, letter|
            incorrect_letters_string = "#{sum} #{letter}"
        end
    end
    
    def display_game
        system('clear')
        show_shark
        display_blanks
        puts ""
        puts '      Guess a letter! If you need help, type *, but the shark will get closer!'
        print SecretWord.find(game.secret_word_id).word.split("") #get rid of this later! just so that we can see the word for now...
        puts ""
        # play_game
        guess_a_letter
    end

    def play_game
        system('clear')
        show_shark
        if @@guess == []
            display_blanks
        else
            puts "      #{@@guess.join}"
        end
        puts ''
        puts '      Guess a letter! If you need help, type *, but the shark will get closer!'
        puts ''
        display_incorrect_guesses
        guess_a_letter
    end

    def already_guessed_correct_letter
        system('clear')
        show_shark
        if @@guess == []
            display_blanks
        else
            puts "      #{@@guess.join}"
        end
        puts ''
        puts '      You must really want to be shark food - you already guessed that letter!'
        puts ''
        display_incorrect_guesses
        puts ''
        self.game.incorrect_guesses += 1
        # guess_a_letter
        end_game?
    end

    def already_guessed_incorrect_letter
        system('clear')
        show_shark
        if @@guess == []
            display_blanks
        else
            puts "      #{@@guess.join}"
        end
        puts ''
        puts '      You already guessed that letter! Guess again'
        puts ''
        display_incorrect_guesses
        self.game.incorrect_guesses += 1
        # guess_a_letter
        end_game?
    end

    def show_hint
        self.game.incorrect_guesses += 1
        system('clear')
        show_shark
        puts "      #{@@guess.join}"
        puts ''
        puts "      The definition of this word is: #{self.game.secret_word.hint}"
        puts '      Guess a letter!'
        play_game
    end


    def display_incorrect_guesses
        puts "      Incorrect letters: #{incorrect_letters_string}"
    end

    def add_incorrect_guess(response)
        wrong_letters << response
    end

    def end_game?
        if self.game.incorrect_guesses == 6
            puts "      you lost!"
        else
            # reponse = gets.chomp.downcase
            play_game
        end
    end
    
    def win_game?
        if @@guess.include?("_ ")
            play_game
        else
            puts "      You live to swim another day #{user.name}!"
            final_score
            # store_score
        end
    end


    def final_score
        score = 1/(self.game.incorrect_guesses + 1).to_f.round(3)
        length_bonus = (split_word.uniq.length.to_f * 0.33).round(3)
        difficulty_bonus = self.game.secret_word.difficulty  
        final_score = (score * difficulty_bonus *length_bonus * 1000).to_f.round(3)
        self.game.score = final_score
        puts "Final score: #{final_score}"
    end

    # def store_score
    #     puts 'Enter your initials below to store your score!'
    #     input = gets.chomp
    #     HighScore.create(user: self.user, score: self.game., initials: input)
    #     puts 'thanks!'
    # end
end





