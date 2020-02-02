class SessionsController < ApplicationController
	skip_before_action :authenticate_request
	def signup
		user = User.create!(user_params)		
		if user
			render :json => {user: user, message: "User created succesfully", status: :success }
		else
			render :json => {message: "Error", status: :unprocessable_entity }
		end
		
	end

	private
	def user_params
		params.require(:user).permit(:email,:password, :name, :password_confirmation)
	end
end
