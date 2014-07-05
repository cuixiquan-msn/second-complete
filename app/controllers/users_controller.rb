class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
  	@user=User.new
  end

  def create
  	@user=User.new(user_params)
  	if @user.save
  		sign_in(@user)
		flash[:success] = "Welcome to the Xiquan's App!"
		#flash[:true] = "Welcome to the Xiquan's App!"
		#flash[:error] = "This is an error!"
		#render 'show'
		redirect_to @user
		#sign_in
	else
		flash[:error]= "Failed verification!"
		render 'new'
	end
  end

  def show
  	@user=User.find(params[:id])
  end

  def index
  	#@users=User.all
  	@users=User.paginate(page: params[:page])
  end

  def edit
  	@user=User.find(params[:id])
  end

  def destroy
  	User.find(params[:id]).destroy
  	flash[:success]="User deleted"
  	redirect_to users_url
  end

  def update
  	@user=User.find(params[:id])
  	if @user.update_attributes(user_params)
  		sign_in(@user)
		flash[:success] = "Welcome to the Xiquan's App!"
		#flash[:true] = "Welcome to the Xiquan's App!"
		#flash[:error] = "This is an error!"
		#render 'show'
		redirect_to @user
		#sign_in
	else
		flash[:error]= "Failed verification!"
		render 'edit'
	end
  end

  private
		def user_params
			params.require(:user).permit(:name, :email, :password,
											:password_confirmation)
		end

		# Before filters
		def signed_in_user
			unless signed_in?
				store_location
				redirect_to signin_url, notice: "Please sign in." 
			end
		end

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end

		def admin_user
			unless current_user.admin?
                 redirect_to root_url
			end 
		end

end
