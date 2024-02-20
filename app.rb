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

# Hompage.erb (ROOT ROUTE)
get("/") do
  api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

  raw_api = HTTP.get(api_url)
  parsed_api = JSON.parse(raw_api)
  raw_currencies =  parsed_api.fetch("currencies")
  @currencies = raw_currencies.values
  @currency_abbreviation = raw_currencies.keys
 erb(:homepage)
end


get("/:currency_one") do
  @currencies = raw_currencies.values
  @currency_abbreviation = raw_currencies.keys

  erb(:currency_template)
end

get ("/:currency_one/:currency_two") do
  #initial currency that needs to be converted
  currency_from = params.fetch("currency_one")
  
  #the currency we want to convert to
  currency_to = params.fetch("currency_two")
  
  #default value 1
  amount ="1"

  #conversion api url
  conversion_url = "http://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{currency_from}&to=#{currency_to}&amount=#{amount}"

  #to json
  raw_conversion_api = HTTP.get(conversion_url)
  parsed_conversion_api = JSON.parse(raw_conversion_api)


  @converted = parsed_conversion_api.fetch("result")
  @currencies = raw_currencies.values
  @currency_abbreviation = raw_currencies.keys

  erb(:conversion)
end
