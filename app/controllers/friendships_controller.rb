class FriendshipsController < ApplicationController
	def create
		friend = User.find(params[:friend])
		current_user.friendships.build(friend_id: friend.id)
		if current_user.save
			flash[:notice] = "Now following."
			redirect_to friends_path
		else
			flash[:alert] = "Something went wrong."
			redirect_to friends_path
		end
	end

	def destroy
		friend_details = current_user.friends.where(id: params[:id]).first
		friend = current_user.friendships.where(friend_id: params[:id]).first
		friend.destroy
		flash[:notice] = "You have stopped following #{friend_details.email}"
		redirect_to friends_path
	end
end
