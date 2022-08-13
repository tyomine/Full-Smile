class Public::CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
       #通知の作成
       @comment.create_notification_comment!(current_user, @post.id)
    else  
      render 'error'
    end
    @comment_new = Comment.new
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
    @comment.destroy
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end  
  
end
