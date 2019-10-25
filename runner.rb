require_relative './config/environment'

new_cli = Cli.new(nil, nil)

# i = 1
# while i < 100
#     pid = fork{ exec 'afplay', "./Jaws-theme-song.mp3" }
#     i += 1
# end

new_cli.start



