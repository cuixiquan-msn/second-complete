class UsersController < ApplicationController
  def new
  	@user=User.new
  end

  def create
  	user=User.new(user_params)
  	if user.save
  		sign_in(user)
		flash[:success] = "Welcome to the Xiquan's App!"
		#flash[:true] = "Welcome to the Xiquan's App!"
		#flash[:error] = "This is an error!"
		#render 'show'
		redirect_to user
		#sign_in
	else
		flash[:error]= "Failed verification!"
		render 'new'
	end
  end

  def show
  	@user=User.find(params[:id])
  end

  private
		def user_params
			params.require(:user).permit(:name, :email, :password,
											:password_confirmation)
		end

end
