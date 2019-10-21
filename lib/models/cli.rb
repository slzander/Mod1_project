class Cli
    attr_accessor :user, :game

    def initialize (user, game)
        @user = user
        @game = game
    end

    def start
        puts "Welcome to the game"
        puts "What's your name?"
        user_name = gets.chomp
        user = User.create(name: user_name)
        puts "Hi #{user.name}!"

    end

    def difficulty
        prompt.select("Choose difficulty", %w(Easy Medium Hard))
        #select random word from chosen difficulty
        game = Game.create(user: user, secret_word: nil, )

    end


end