class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to comment.shop, notice: "コメントを保存しました。"
    else
      flash[:error_messages] = comment.errors.full_messages
      redirect_back fallback_location: comment.shop
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.shop, notice: "コメントが削除されました"
  end

  private
   def comment_params
    params.require(:comment).permit(:shop_id, :name, :comment)
  end
end
