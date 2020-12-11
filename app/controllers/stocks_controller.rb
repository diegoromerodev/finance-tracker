class StocksController < ApplicationController

	def search
		if params[:stock].present?
			@stock = Stock.price_look(params[:stock])
			if @stock
				@stock_logo = "https://storage.googleapis.com/iex/api/logos/#{params[:stock].upcase}.png"
				respond_to do |format|
					format.js { render partial: 'users/result' }
				end
			else
				respond_to do |format|
					flash.now[:alert] = "Please enter a valid stock ticker."
					format.js { render partial: 'users/result' }
				end
			end
		else
			respond_to do |format|
				flash.now[:alert] = "Please enter a stock ticker."
				format.js { render partial: 'users/result' }
			end
		end
	end 

end