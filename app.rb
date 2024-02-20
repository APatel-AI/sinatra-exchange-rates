require "http"
require "json"
require "sinatra"
require "sinatra/reloader"

# Available Currencies
api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

raw_api = HTTP.get(api_url)
parsed_api = JSON.parse(raw_api)
raw_currencies =  parsed_api.fetch("currencies")

@currencies = raw_currencies.values
@currency_abbreviation = raw_currencies.keys

# Home Screen

get("/") do
  api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

  raw_api = HTTP.get(api_url)
  parsed_api = JSON.parse(raw_api)
  raw_currencies =  parsed_api.fetch("currencies")
  @currencies = raw_currencies.values
  @currency_abbreviation = raw_currencies.keys
 erb(:homepage)
end
