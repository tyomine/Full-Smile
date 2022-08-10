class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    if @range == "User"
      @users = User.page(params[:page]).looks(params[:search], params[:word])
    elsif @range == "Post"
      @posts = Post.page(params[:page]).looks(params[:search], params[:word])
    end
  end
  
end
