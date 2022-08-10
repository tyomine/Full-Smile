class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_guest_user, only: [:new]
  
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
    @comment = Comment.new
  end

  def index
    @posts = Post.page(params[:page]).order(created_at: :desc)
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
    params.require(:post).permit(:title, :body, :image,)
  end
  
  def ensure_guest_user
    if current_user.name == "guestuser"
      redirect_to posts_path, alert: 'ゲストユーザーは投稿できません。'
    end
  end  
  
  
end
