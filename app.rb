require 'rubygems'
require 'sinatra'
require 'json'
require 'geckoboard-push'

class Hash
  def symbolize_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)
    end
    self
  end
end

get '/' do
  @config = YAML.load_file("config.yml")
  @widgets = @config['widgets']

  # if set, environment variable GECKOBOARD_API_KEY will override settings.yml
  @api_key = ENV['GECKOBOARD_API_KEY'] || @config['geckoboard_api_key']
  
  erb :index
end

post '/push' do
  params.symbolize_keys!

  # take the parameters and push to Geckoboard
  begin
    Geckoboard::Push.api_key = params[:api_key]

    if params[:widget_type] == "text"
      # symbolize keys and only send if there's actually a value
      data = params[:widget_data].map(&:symbolize_keys!).select{|t| !t[:text].empty? }
      raise 'No input data' if data.empty?
      it_worked = Geckoboard::Push.new(params[:widget_key]).text(data)
    else
      raise "Not supporting '#{params[:widget_type]}' widgets yet."
    end
    msg = (it_worked == true ? "Successfully updated widget!" : "Something went wrong, sorry.")
  rescue Exception => e
    # oops, got an error. Try to display to the user
    puts e.message
    msg = "Sorry, an error occurred: '#{e.message}'"
  end
  
  return msg
end