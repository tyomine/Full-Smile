# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).order(created_at: :desc)
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
    @user.update(user_params)
    redirect_to admin_user_path(@user), notice: "#{@user.name}さんの会員ステータスを更新しました"
  end

  private
    def user_params
      params.require(:user).permit(:user_status)
    end
end
