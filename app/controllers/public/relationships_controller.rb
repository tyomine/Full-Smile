class Public::RelationshipsController < ApplicationController
  
  # フォローする時
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  # フォロー外す時
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end  
  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings.page(params[:page])
  end
  # フォローワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers.page(params[:page])
  end
  
end
