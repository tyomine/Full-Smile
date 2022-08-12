class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end
  
  def unsubscribe
    @user = User.find(params[:user_id])
  end
  
  def withdrawal
    @user = User.find(params[:user_id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "ユーザーの退会処理を実行しました。"
    redirect_to admin_users_path
  end
  
end
