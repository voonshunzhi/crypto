class HomeController < ApplicationController
  
  def index
    require "net/http"
  	require "json"
  	@url = "https://api.coinmarketcap.com/v1/ticker/"
  	@uri = URI(@url)
  	@response = Net::HTTP.get(@uri)
  	@coins = JSON.parse(@response)
  end
  
  def lookup
    require "net/http"
  	require "json"
  	@url = "https://api.coinmarketcap.com/v1/ticker/"
  	@uri = URI(@url)
  	@response = Net::HTTP.get(@uri)
  	@lookup_coins = JSON.parse(@response)
    @symbol = params[:name].upcase if params[:name]
  end
  
  def about
    
  end
end
