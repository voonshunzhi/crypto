class CryptocurrenciesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_crypto,only:[:edit,:update,:destroy,:show]
  before_action :same_people?,only:[:edit,:show]
  
  def index
    require "net/http"
  	require "json"
    @cryptos = current_user.cryptocurrencies
  	@url = "https://api.coinmarketcap.com/v1/ticker/"
  	@uri = URI(@url)
  	@response = Net::HTTP.get(@uri)
  	@lookup_cryptos = JSON.parse(@response)
    @symbol = params[:name].upcase if params[:name]
  end
  def show
    require "net/http"
  	require "json"
    @cryptos = current_user.cryptocurrencies
  	@url = "https://api.coinmarketcap.com/v1/ticker/"
  	@uri = URI(@url)
  	@response = Net::HTTP.get(@uri)
  	@lookup_cryptos = JSON.parse(@response)
  end
  def new
    @cryptocurrency = Cryptocurrency.new
  end
  def create
    @crypto = Cryptocurrency.new(crypto_param)
    @crypto.user = current_user
    if @crypto.save
      flash[:success] = "You have successfully added crypto!"
      redirect_to cryptocurrencies_path
    else
      flash.now[:danger] = "There is an error preventing you from saving the coins!"
      render "new"
    end
  end
  def edit
    
  end
  def destroy
    @cryptocurrency.delete
    flash[:success] = "You have successfully deleted crypto!"
    redirect_to cryptocurrencies_path
  end
  def update
    if @cryptocurrency.update(crypto_param)
      flash[:success] = "You have successfully updated the crypto!"
      redirect_to cryptocurrencies_path
    else
      flash.now[:danger] = "There is an error preventing you from updating the coins!"
      render "edit"
    end
  end
  private
  def crypto_param
    params.require(:cryptocurrency).permit(:cost_per,:symbol,:amount_owned)
  end
  def find_crypto
    @cryptocurrency = Cryptocurrency.find(params[:id])
  end
  def same_people?
    if @cryptocurrency.user != current_user
      flash[:warning] = "You cannot edit or view others portfolio." 
      redirect_back(fallback_location: cryptocurrencies_path) 
    end
  end
end
