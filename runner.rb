require_relative './config/environment'

new_cli = Cli.new(nil, nil)

# afplay jaws_theme_song.mp3
pid = fork{ exec 'afplay', "./Jaws-theme-song.mp3" }



new_cli.start



