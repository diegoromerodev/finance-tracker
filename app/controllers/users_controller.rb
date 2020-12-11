class UsersController < ApplicationController
  def my_portfolio
  	@tracked_stocks = current_user.stocks
  	@user = current_user
  end

  def show
  	@user = User.find(params[:id])
  	@tracked_stocks = @user.stocks
  end

  def friends
  	@tracked_users = current_user.friends
  end

  def search
	if params[:friend].present?
		@friends = User.search(params[:friend])
		@friends = current_user.except_current(@friends)
		if @friends
				respond_to do |format|
				format.js { render partial: 'users/friends_result' }
			end
		else
			respond_to do |format|
				flash.now[:alert] = "Please enter a valid user."
				format.js { render partial: 'users/friends_result' }
			end
		end
	else
		respond_to do |format|
			flash.now[:alert] = "Please enter a user to search."
			format.js { render partial: 'users/friends_result' }
		end
	end
  end
end
