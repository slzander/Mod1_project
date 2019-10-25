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
        puts shark_eating_swimmer_sequence
        puts "      What's your name?"
        print "      "
        user_name = gets.chomp.capitalize
        self.user = User.create(name: user_name)
        welcome_player
    end

    def welcome_player
        system('clear')
        puts chompman_title
        puts "      Hi #{user.name}!"
        puts ""
        play_or_add_word
        # difficulty
        # display_game
    end

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
        puts '      Your diver friend needs your help!'
        puts '      You will need to solve this word puzzle to save them from the shark!'
        puts ''
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
        display_game
    end
    
    def display_game
        system('clear')
        show_shark
        display_blanks
        puts ""
        puts '      Guess a letter!'
        puts '      If you need a hint, type  ? , but the shark will get closer!'
        puts '      Type  *  if you would like to guess the word'
        # puts '      Guess a letter! OR type  *  to guess the word. If you need a hint, type  ? , but the shark will get closer!'
        # print SecretWord.find(game.secret_word_id).word.split("") #get rid of this later! just so that we can see the word for now...
        print "      "
        get_response
        guess_a_letter
    end


    def guess_a_letter
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
        elsif @@response == '?'
            show_hint
            # guess_a_letter
        elsif @@response == '*'
            guess_word
            # guess_a_letter
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
        puts '      Guess a letter!'
        puts '      If you need a hint, type  ? , but the shark will get closer!'
        puts '      Type  *  if you would like to guess the word'
        # puts '      Guess a letter! OR type  *  to guess the word. If you need a hint, type  ? , but the shark will get closer!'
        print '      '
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
        puts '      You must want your friend to be shark bait - you already guessed that letter!'
        puts ''
        puts '      Guess a letter!'
        puts '      If you need a hint, type  ? , but the shark will get closer!'
        puts '      Type  *  if you would like to guess the word'
        # puts '      PRESS ENTER TO CONTINUE'
        # display_incorrect_guesses
        self.game.incorrect_guesses += 1
        print "      "
        get_response
        end_game?
    end

    def invalid_entry
        system('clear')
        show_shark
        if @@guess == []
            display_blanks
        else
            puts "      #{@@guess.join}"
        end
        puts ''
        # display_incorrect_guesses
        puts '      That is not a valid input!'
        puts ''
        puts '      Please type one of the following:'
        puts '          1. a single letter'
        puts '          2. *   (to guess the word)'
        puts '          3. ?   (for a hint)'
        print '      '
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
        puts '      Guess a letter!'
        puts '      Type  *  if you would like to guess the word'
        print "      "
        get_response
        guess_a_letter
    end

    def guess_word
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
        puts "      Enter your guess for the word! If you're wrong, the shark will get closer!"
        print '      '
        get_response
        if @@response == self.game.secret_word.word
            you_win
        else
            self.game.incorrect_guesses += 1
            @@incorrect_letters << @@response
            end_game?
        end
    end

    def end_game?
        if self.game.incorrect_guesses == 6
            loser_shark_eating_swimmer_sequence
            play_again?
        else
            play_game
        end
    end
    
    def win_game?
        if @@guess.include?("_ ")
            play_game
        else
            you_win
        end
    end

    def play_again?
        prompt = TTY::Prompt.new
        easy = SecretWord.all.select {|word| word.difficulty == 1}
        medium = SecretWord.all.select {|word| word.difficulty == 2}
        hard = SecretWord.all.select {|word| word.difficulty == 3}
        response = prompt.select("      What would you like to do?", ["       Play again", "       Add a new word", "       Exit"])
        if response == "       Play again"
            store_score
            @@guess = []
            @@incorrect_letters = []
            @@response = ""
            difficulty
        elsif response == "       Add a new word"
            @@guess = []
            @@incorrect_letters = []
            @@response = ""
            store_score
            add_word_to_game
        else
            system('clear')
            puts chompman_no_title
            puts '                                           THANKS FOR PLAYING!'
            puts ''
            puts ''
            pid = fork{exec 'killall', "afplay"}
            store_score
            exit
        end
    end

    def you_win
        @@guess = SecretWord.find(game.secret_word_id).word
        system('clear')
        winner_diver_escape_sequence
        puts ''
        puts "      #{@@guess.capitalize}: #{self.game.secret_word.hint}"
        puts ''
        final_score
        puts ''
        play_again?
        # store_score
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

    def add_word_to_game
        system('clear')
        print chompman_title
        print "      Type the word you would like to add:"
        print "    "
        new_word = gets.chomp
        print "      Type the definition for the word:"
        print "       "
        new_definition = gets.chomp
        prompt = TTY::Prompt.new
        new_difficulty = prompt.select("      Rate the difficulty of the word:", ["       Easy", "       Medium", "       Hard"])
        if new_difficulty == "       Easy"
            new_difficulty = 1
        elsif new_difficulty == "       Medium"
            new_difficulty = 2
        else
            new_difficulty = 3
        end
        SecretWord.create(word: new_word, hint: new_definition, difficulty: new_difficulty)
        puts ""
        puts "      Thanks for adding a new word to the game!"
        puts ""
        play_or_add_word
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
            puts "      Incorrect guesses: #{incorrect_letters_string}"
        end
    
    def get_response
        @@response = gets.chomp.downcase
    end

    def guess_bonus 
        if @@guess.count("_ ") == 0
            guess_bonus = 0.01
        else
            guess_bonus = (@@guess.count("_ ") * 0.5).round(3) 
        end
    end
    
    def store_score
        HighScore.create(user_name: self.user.name, score: self.game.score)
    end

    def best_player
        HighScore.order('score').last.user_name
    end

    def best_score
        HighScore.order("score").last.score
    end

   

    def final_score 
        score = 1/(self.game.incorrect_guesses + 1).to_f.round(3)
        length_bonus = (split_word.uniq.length.to_f * 0.33).round(3)
        difficulty_bonus = self.game.secret_word.difficulty 
        final_score = (score * (difficulty_bonus + length_bonus + guess_bonus) * 1000).to_f.round(3)
        self.game.score = final_score
        if best_player == self.user.name
            puts "      Your final score: #{final_score}   Current scoreboard leader: YOU with a score of #{best_score} "
        elsif best_score < self.game.score
            puts"       Your final score: #{final_score}   You're the new scoreboard leader! "
        else    
            puts "      Your final score: #{final_score}   Current scoreboard leader: #{best_player} #{best_score} "  
        end
    end

end











