# frozen_string_literal: true

class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_root_path, notice: "削除が完了しました。"
  end
end
