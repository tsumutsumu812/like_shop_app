class CommentsController < ApplicationController
  before_action :login_required, only: [:create, :destroy]
  before_action :delete_authente, only: [:destroy]

  def create
    comment = current_user.comments.new(comment_params)
    if comment.save
      redirect_to comment.shop, flash: { success: "コメントを保存しました。" }
    else
      #flash[:danger] = comment.errors.full_messages
      redirect_back fallback_location: comment.shop, flash: { danger: "コメントは255文字以内で記入してください" }
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to comment.shop, flash: { success: "コメントが削除されました" }
  end

  private
   def comment_params
    params.require(:comment).permit(:shop_id, :title, :comment)
  end

  def delete_authenticate
    shop = Shop.find(params[:id])
    comment = Comment.find(params[:id]) 
    unless current_user.id == comment.user.id || current_user.id == shop.user.id || current_user.admin?
      redirect_to shops_path, flash: { danger: "削除権限がありません" } 
    end
  end
end
