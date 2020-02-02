class UsersController < ApplicationController

	def user_detail
		user = current_user
		# respond_to do |format|
			if user
				render json: { user: user, followers: user.followers,following: user.followed_users, message: "User Details", status: :success }
			else
				render json: { message: "User Not Found", status: :unprocessable_entity }
			end
		# end
	end

	def follow
		unless current_user.following?(params[:user_id])
			render_object current_user.follow!(params[:user_id])
		else
			render json: {status: :success, message: "Already Followed"}
		end
	end

	def unfollow
		if current_user.following?(params[:user_id])
			if current_user.unfollow!(params[:user_id])
				render json: {status: :success, message: "UnFollowed Successfully"}
			else
				render json: {status: :unprocessable_entity, message: "Something went wrong!"}
			end
		else
			render json: {status: :success, message: "You are not following this user!"}
		end
	end

	def tweets
		tweets = current_user.tweets.order("id desc")
		if tweets
			render json: { tweets: tweets, status: :success, message: "Success"}
		else
			render json: { tweets: [], status: :success, message: "No tweets found"}
		end
	end

	def followers
		followers = current_user.followers
		if followers
			render json: { followers: followers, status: :success, message: "Success"}
		else
			render json: { followers: [], status: :success, message: "No followers found"}
		end
	end

	def followers_tweet
		followers_tweet = Tweet.where(user_id: current_user.followers.pluck(:id))
		if followers_tweet
			render json: { followers_tweet: followers_tweet, status: :success, message: "Success"}
		else
			render json: { followers_tweet: [], status: :success, message: "No followers found"}
		end
	end


	private
	def user_params
		params.require(:user).permit(:name,:email, :password, :password_confirmation)
	end
end
