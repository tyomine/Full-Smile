class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id), notice: "投稿が成功しました。"
    else
      flash.now[:alert] = "投稿が失敗しました。"
      render :new
    end  
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
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: "編集が成功しました。"
    else
      flash.now[:alert] = "編集が失敗しました。"
      render :edit
    end  
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path, notice: "削除が完了しました。"
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
  
  
end
