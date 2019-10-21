require 'sinatra/activerecord'
require 'sqlite3'
require 'require_all'
require 'pry'
require 'tty-prompt'

require_all 'lib'
prompt = TTY::Prompt.new
