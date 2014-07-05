class SessionsController < ApplicationController
	def new
		#@user=User.new
	end

	def create
		user=User.find_by(email: params[:session][:email].downcase)
		if !user.nil? && user.authenticate(params[:session][:password])
			flash[:success]= "Welcome!"
			sign_in(user)
			redirect_back_or(user)
			#redirect_to user
		else
            flash[:error]= "Failed verification!"
            redirect_to signin_path
            #render "new"
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end

	
end
