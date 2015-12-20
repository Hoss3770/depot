class StoreController < ApplicationController

  def index
    @products = Product.order(:title)
    if session[:counter]
      session[:counter] += 1
    else
      session[:counter] = 0
    end
    @counter = session[:counter]
  end
end
