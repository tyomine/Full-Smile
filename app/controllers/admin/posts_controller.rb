class Admin::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end
end
