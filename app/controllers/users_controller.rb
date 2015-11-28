class UsersController < ApplicationController

  def show
  	 @user = User.find(params[:id])
  	 # binding.pry
  end

  def new
 @user = User.new
end

 def create
 @user = User.new(user_params)
   if @user.save
   	 #handle sucessfull reuqest
     flash[:success] = "Welcome to the OKCuPId!"
 redirect_to @user
     #render 'show'
	else
  render 'new'
   end

end



private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end



end