class UserStocksController < ApplicationController
	def create
		stock = Stock.find_existing(params[:ticker])
		if stock.blank?
			stock = Stock.price_look(params[:ticker])
			stock.save
		end
		@user_stock = UserStock.create(user: current_user, stock: stock)
		flash[:notice] = "#{stock.name.capitalize} is now being tracked."
		redirect_to my_portfolio_path
	end

	def destroy
		stock = Stock.find(params[:id])
		user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
		user_stock.destroy
		flash[:notice] = "#{stock.name.capitalize} is not being tracked anymore."
		redirect_to my_portfolio_path
	end
end
