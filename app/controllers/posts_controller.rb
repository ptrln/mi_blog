class PostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authorize_user!, only: [:edit, :update, :destroy]
  
  POSTS_PER_LOAD = 3

  def index
    @posts = current_user.following_posts
    if (params[:last] && params[:last].length > 0)
      @posts = @posts.where("created_at > ?", DateTime.strptime(params[:last]) + 1.second)
    end
    if (params[:offset])
      @posts = @posts.offset(params[:offset])
    end
    @posts = @posts.limit(POSTS_PER_LOAD)
    posts_html = render_to_string :ajax_index, :layout => false
    render :json => {
      html: posts_html, 
      last: @posts.first ? @posts.first.created_at : params[:last],
      more: @posts.count >= POSTS_PER_LOAD
    }
  end

  def show
    @user = User.find_by_username(params[:user_id])
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      redirect_to current_user
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to current_user
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to current_user
  end

  private
  def authorize_user!
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to :back
    end
  end
end
