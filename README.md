CHOMPMAN is a Hangman inspired CLI app created by Stacey Zander and Jessica Werbach.

Your friend Scoobert Ada Daniel Iver (aka "Scoob" A. D. Iver), has unqittingly found themselves in the path of a hungry shark.
It's your job to alert them to the danger in time to escape. To do so you need to shout the right "shark-warning-word", which
you seem to have, unfortuantely, forgotten. You only have 6 guesses to get it right, as any distractions from wrong guesses or 
reading a hint will you cost you precious time. 

So, dive into CHOMPMAN... and here's hoping you're a good speller!

![image](./chompman_img.png?raw=true "chompman image")


Install Instructions:
In order to play the game you will need to:

1. Have a text editor such as VSCode.

2. Install the gems listed within the Gem file. Do this by running the command   'bundle install'  
   (The required gems are also listed below for reference)

        - gem "activerecord", "~> 6.0"
        - gem "sqlite3", "~> 1.4"
        - gem "sinatra", "~> 2.0"
        - gem "sinatra-activerecord", "~> 2.0"
        - gem "require_all", "~> 2.0"
        - gem 'tty-prompt'

3. Run the command   'rake db:migrate'   this will create the database for your game to use.

4. Run the command   'rake db:seed'   this will fill a database with the words your game will use. (Note: you will also have an 
   opportunity to add your own words to this database when you start the game)

5. Run the command   'ruby runner.rb'   to start the game!



Playing the Game:

1. Following the opening animation, you will be asked for your name.
   Type in what you would like the game to refer to you as, then press ENTER on your keyboard.

2. The following screens will have instructions written out for you based on your choices and keyboard inputs.

 |^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^-^|
 |                                                                                                               |
 | IMPORTANT NOTE: During the game you must press ENTER after your inputs for the  game to register your answers |
 |                                                                                                               |
 |v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v-v|


