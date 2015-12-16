class UsersController < ApplicationController
include SessionsHelper

 before_action :logged_in_user, only: [:edit, :update]
  def show
  	 @user = User.find(params[:id])
@microposts = @user.microposts.paginate(page: params[:page])
  	 # binding.pry
  end

  def new
 @user = User.new
end

#for editing user
def edit
    @user = User.find(params[:id])
  end

def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
        flash[:success] = "Profile updated"
      redirect_to @user

    else
      render 'edit'
    end
  end



 def create
 @user = User.new(user_params)
   if @user.save
     log_in @user
   	 #handle sucessfull reuqest
     flash[:success] = "Welcome to the OKCuPId!"
 redirect_to @user
     #render 'show'
	else
  render 'new'
   end
end 

  
# Confirms the correct user
    def correct_user
      @user = User.find(params[:id])
       redirect_to(root_url) unless current_user?(@user)
    end



def index
    @users = User.paginate(page: params[:page])
  end







private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end



end