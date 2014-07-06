class StaticPagesController < ApplicationController
  def about
  end
  
  def contact
  end

  def home
  	  if signed_in?
  	  	  #build an empty micropost for the form
	      @micropost = current_user.microposts.build 
	      #fill the feed_items associated with current user
	      @feed_items = current_user.feed.paginate(page: params[:page])
  	  end
  end 
end
