class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    #current_userの投稿に紐づいた通知一覧
    @notifications = current_user.passive_notifications.page(params[:page]).order(created_at: :desc)
    # @notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
    @user = current_user
  end

  def destroy_all
    #通知を全削除
  	@notifications = current_user.passive_notifications.destroy_all
  	redirect_to user_notifications_path
  end

end
