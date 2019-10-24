require 'tty-prompt'


class Cli
    attr_accessor :user, :game

    @@guess = []
    @@incorrect_letters = []
    @@response = ""


    def initialize(user, game)
        @user = user
        @game = game
    end

    def start
        system('clear')
        # puts shark_eating_swimmer_sequence
        puts "      What's your name?"
        print "      "
        user_name = gets.chomp
        self.user = User.create(name: user_name)
        system('clear')
        puts chompman_title
        puts "      Hi #{user.name}!"
        puts ""
        # wrong_letters = []
        difficulty
        display_game
    end

    # def play_or_add
    #     would you like to play or add a new word?
    # end

    def difficulty
        prompt = TTY::Prompt.new
        easy = SecretWord.all.select {|word| word.difficulty == 1}
        medium = SecretWord.all.select {|word| word.difficulty == 2}
        hard = SecretWord.all.select {|word| word.difficulty == 3}
        response = prompt.select("      Choose your difficulty", ["       Easy", "       Medium", "       Hard"])
        if response == "       Easy"
            chosen_word = easy.sample
        elsif response == "       Medium"
            chosen_word = medium.sample
        else
            chosen_word = hard.sample
        end
        self.game = Game.create(user: self.user, secret_word: chosen_word, incorrect_guesses: 0, win?: false, score: 0)
    end
    
    def display_game
        system('clear')
        show_shark
        display_blanks
        puts ""
        puts '      Guess a letter! If you would like to see a hint, type *, but the shark will get closer!'
        print SecretWord.find(game.secret_word_id).word.split("") #get rid of this later! just so that we can see the word for now...
        puts ""
        get_response
        guess_a_letter
    end

    def guess_a_letter
        # response = gets.chomp.downcase
        # system('clear')
        possible_letters = ('a'..'z').to_a
        if possible_letters.include?(@@response) && @@guess.exclude?(@@response) #&& @@incorrect_letters.exclude?(@@response)
            if split_word.include?(@@response)
                add_correct_guess(@@response)
                win_game?
            elsif @@incorrect_letters.include?(@@response)
                already_guessed_letter
                # puts '      You must really want to be shark food - you already guessed that letter!'
                # self.game.incorrect_guesses += 1
                # end_game?
            else
                add_incorrect_letter(@@response)    
                # self.game.incorrect_guesses += 1 
                #     @@incorrect_letters << @@response 
                end_game?
            end
        elsif @@response == '*'
            show_hint
            guess_a_letter
        elsif @@guess.include?(@@response) #|| @@incorrect_letters.include?(response)
            already_guessed_letter
            # puts '      You already guessed that letter! Guess again'
            # guess_a_letter
        else
            invalid_entry
            # puts '      That is not a valid input! Please type any single letter or *'
            # get_response
            # guess_a_letter
        end
        # print @@guess.join
        # puts ""
        # get_response
        # guess_a_letter
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
        display_incorrect_guesses
        puts ''
        puts '      Guess a letter! If you would like to see a hint, type *, but the shark will get closer!'
        puts ''
        get_response
        guess_a_letter
    end
    
    def add_incorrect_letter(response)
        self.game.incorrect_guesses += 1 
        @@incorrect_letters << @@response 
    end

    def already_guessed_letter
        system('clear')
        show_shark
        if @@guess == []
            display_blanks
        else
            puts "      #{@@guess.join}"
        end
        puts ''
        display_incorrect_guesses
        puts ''
        puts '      You must really want to be shark food - you already guessed that letter!'
        puts ''
        puts '      PRESS ENTER TO CONTINUE'
        puts ''
        # display_incorrect_guesses
        puts ''
        self.game.incorrect_guesses += 1
        get_response
        end_game?
    end

    # def already_guessed_incorrect_letter
    #     system('clear')
    #     show_shark
    #     if @@guess == []
    #         display_blanks
    #     else
    #         puts "      #{@@guess.join}"
    #     end
    #     puts ''
    #     puts '      You already guessed that letter! Press enter to continue'
    #     puts ''
    #     display_incorrect_guesses
    #     self.game.incorrect_guesses += 1
    #     get_response
    #     end_game?
    # end

    def invalid_entry
        system('clear')
        show_shark
        if @@guess == []
            display_blanks
        else
            puts "      #{@@guess.join}"
        end
        puts ''
        display_incorrect_guesses
        puts ''
        puts '      That is not a valid input! Please type a single letter or type * for a hint'
        puts ''
        # display_incorrect_guesses
        get_response
        guess_a_letter
    end

    def show_hint
        self.game.incorrect_guesses += 1
        system('clear')
        if self.game.incorrect_guesses > 5
            end_game?
        else
            show_shark
        end
        if @@guess == []
            display_blanks
        else
            puts "      #{@@guess.join}"
        end
        puts ''
        puts "      The definition of this word is: #{self.game.secret_word.hint}"
        puts ''
        puts '      PRESS ENTER TO CONTINUE'
        get_response
        guess_a_letter
    end

    def end_game?
        if self.game.incorrect_guesses == 6
            puts loser_shark_eating_swimmer_sequence
            exit #change this to 'would you like to play again?'
        else
            play_game
        end
    end
    
    def win_game?
        if @@guess.include?("_ ")
            play_game
        else
            system('clear')
            show_shark
            puts "      #{@@guess.join}"
            puts ''
            puts "      Definition: #{self.game.secret_word.hint}"
            puts ''
            puts "      Congrats #{user.name}! They will live to swim another day!"
            puts ''
            final_score
            puts ''
            # store_score
            exit #change this to 'would you like to play again?'
        end
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
        SecretWord.find(self.game.secret_word_id).word.split("")
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

    def incorrect_letters_string
        @@incorrect_letters.reduce do |sum, letter|
            incorrect_letters_string = "#{sum} #{letter}"
        end
    end
    
        def display_incorrect_guesses
            puts "      Incorrect letters: #{incorrect_letters_string}"
        end
    
    def get_response
        @@response = gets.chomp.downcase
    end



    def final_score
        score = 1/(self.game.incorrect_guesses + 1).to_f.round(3)
        length_bonus = (split_word.uniq.length.to_f * 0.33).round(3)
        difficulty_bonus = self.game.secret_word.difficulty  
        final_score = (score * difficulty_bonus *length_bonus * 1000).to_f.round(3)
        self.game.score = final_score
        puts "      Final score: #{final_score}"
    end

    # def store_score
    #     puts 'Enter your initials below to store your score!'
    #     input = gets.chomp
    #     HighScore.create(user: self.user, score: self.game., initials: input)
    #     puts 'thanks!'
    # end
end





