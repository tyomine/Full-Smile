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
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
  
  
end
