class UsersController < ApplicationController

  before_action :signed_in_user, only: [:edit, :update, :index, :show]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :signed_in_user_no_need, only: [:new, :create]

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
  	@microposts = @user.microposts.paginate(page: params[:page])
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
		
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_url) unless current_user?(@user)
		end

		def admin_user
			unless current_user.admin?
                 redirect_to root_url
			end 
		end

		def signed_in_user_no_need
			if signed_in? 
				redirect_to(root_url)
			end
		end

end
