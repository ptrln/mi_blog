class IndexController < ApplicationController
  def index
    if user_signed_in?
      @post = Post.new
      @posts = current_user.following_posts
      render :posts_index
    else
      render :guest_index
    end
  end
end
