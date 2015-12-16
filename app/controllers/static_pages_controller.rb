class StaticPagesController < ApplicationController
  
  include SessionsHelper
  
  def home
@micropost = current_user.microposts.build if logged_in?
@feed_items = current_user.feed.paginate(page: params[:page])   
  end

  def help
  	#render layout: 'false'
  
    #if you want to show the particular layout in that action make it false
  end

  def about
  end

  def contact
  end

end

