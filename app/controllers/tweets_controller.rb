class TweetsController < ApplicationController

	def create_tweet
		tweet = current_user.tweets.create!(tweet_params)
		if tweet
			render json: tweet: tweet, message: "Tweet created succesfully", status: :success 
		else
			render json: message: "Error", status: :unprocessable_entity 
		end
		
	end

	def destroy_tweet
		tweet = Tweet.find(parmas[:id])
		respond_to do |format|
	    	if tweet && tweet.destroy!
		      render json: message: "Tweet deleted succesfully", status: :success 
		    else
		      render json: message: "Error", status: :unprocessable_entity 
		    end
	  	end

	end

	private
	def tweet_params
		params.require(:tweet).permit(:user_id,:content)
	end

end
