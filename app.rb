require 'rubygems'
require 'sinatra'
require 'json'
require 'geckoboard-push'

enable :sessions

get '/' do

  if session[:data].nil? then
    session[:data] = {
      # if set, environment variable GECKOBOARD_API_KEY will be used and the user won't be asked for API key
      'api_key' => ENV['GECKOBOARD_API_KEY']  
    }
  end
  
  erb :index
end

post '/push' do

  # take the three parameters and push to Geckoboard
  begin
    Geckoboard::Push.api_key = params['api_key']
    response = Geckoboard::Push.new(params['widget_key']).text [{:text => params['text']}]
    session[:message] = "Successfully updated widget!"
  rescue Exception => e
    # oops, got an error. Try to display to the user
    # puts e
    puts e.message
    session[:error] = "Sorry, an error occurred: '#{e.message}'"
  end
  
  session[:data] = {}.merge(params)  # retain what was POSTed when redrawing the page.
  redirect '/'

end