require 'sinatra/activerecord'
require 'sqlite3'
require 'require_all'
# require 'paint'
require 'pry'


require_all 'lib'
ActiveRecord::Base.logger = nil

