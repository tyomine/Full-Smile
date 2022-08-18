class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  before_action :set_user, only: [:likes]
  
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "編集が成功しました。"
    else
      flash.now[:alert] = "編集が失敗しました。"
      render :edit
    end  
  end
  
  def likes
    post_ids = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.where(id: post_ids).page(params[:page])
  end
  
  def unsubscribe
    @user = User.find(params[:user_id])
  end  
  
  def withdrawal
    @user = User.find(params[:user_id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def correct_user
    @user = User.find(params[:id])
    @posts = @user.posts
    redirect_to user_path(current_user) unless @user == current_user
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user), alert: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
  
end
