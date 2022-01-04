require 'sinatra'
require 'securerandom'
require 'socket'
require 'rubygems'
require 'sqlite3'

db = SQLite3::Database.open 'app.db'
db.execute 'CREATE TABLE IF NOT EXISTS shortie(url VARCHAR(255), shortie VARCHAR(255))'
db.results_as_hash = true

get '/' do
 erb :index
end    

post '/' do
  url = params[:url]
  host = 'localhost:4567' 
  random_hex_characters  = SecureRandom.hex(5)
  save_shortie = "#{host}" + "/" + "#{random_hex_characters}"
  db = SQLite3::Database.open 'app.db'
  db.execute 'INSERT INTO shortie (url, shortie) VALUES (?, ?)', url,   save_shortie 
  @shortie_url = "#{host}" + "/" + "#{random_hex_characters}"
end    

get '/:shortie' do
   #get the url that matches the shortie
   s = "localhost:4567/#{params[:shortie]}"
   query = 'SELECT url FROM shortie WHERE shortie = ?'
   url = db.get_first_value query, s
   redirect url
end    