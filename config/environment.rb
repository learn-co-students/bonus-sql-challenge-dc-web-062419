require 'bundler'
Bundler.require

# Setup a DB connection here

require 'sqlite3'
require 'pry'
DB = {:conn => SQLite3::Database.new('./db/daily_show_guests.db')}
