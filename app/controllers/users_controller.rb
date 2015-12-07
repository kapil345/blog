class UsersController < ApplicationController
include SessionsHelper

 before_action :logged_in_user, only: [:index,:edit, :update,:destroy]
 before_action :correct_user,   only: [:edit, :update]
 before_action :admin_user,     only: :destroy

  def show
  	 @user = User.find(params[:id])
  	 # binding.pry
  end

  def index
@users = User.paginate(page: params[:page])
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



def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
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


 #Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end



  #cofirms a logged in user
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

# Confirms the correct user
    def correct_user
      @user = User.find(params[:id])
       redirect_to(root_url) unless current_user?(@user)
    end




private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end



end