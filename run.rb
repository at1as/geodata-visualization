require 'redis'
require 'sinatra'
require "sinatra/json"
require 'sinatra/streaming'
require 'tilt/erubis'
require 'thin'

set :views, File.expand_path('../', __FILE__)
set :public_dir, File.expand_path('../', __FILE__)

# Multiple simultaneous sessions. All sessions will be invalidated on app restart
enable :sessions
set :session_secret, rand(36**10).to_s(36)


configure do
  $r = Redis.new
  $redis_key = "coordinates"
  
  $polling_interval = ENV['INTERVAL'] || 500
  $center_globe = ENV['RECENTER'] ? true : false
end


get '/' do
  @poll_interval = $polling_interval
  @recenter = $center_globe
  
  erb :index
end

get '/geography' do

  if (coords = $r.rpop($redis_key))
    # Expected format of redis entries is "30.000,-80.000"
    lat, long = coords.split(',').map {|val| val.strip }
  else
    return 204
  end

  json :latitude => lat, :longitude => long
end

