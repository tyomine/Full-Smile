class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "#{@user.name}さんの会員ステータスを更新しました"
    else
      render "edit"
    end
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
  
  private

  def user_params
    params.require(:user).permit(:user_status)
  end
  
end
