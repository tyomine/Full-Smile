class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
    
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to post_path(@post)
  end  

  def show
    @post = Post.find(params[:id])
  end

  def index
    @post = Post.all
    @user = current_user
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
  
  
end
