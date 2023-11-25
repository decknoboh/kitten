class Public::CommentsController < ApplicationController

  def create
    comment = current_user.comments.new(comment_params)
    comment.user_id = current_user.id
    comment.post_id = params[:post_id]
    comment.save
    redirect_to post_path(params[:post_id])
  end

  def edit
    @comment = comment_find_params_id
  end

  def update
    @comment = comment_find_params_id
    if @comment.update(comment_params)
      notice("コメントを更新しました。")
      redirect_to post_path(@comment.post_id)
    else
      render :edit
    end
  end

  def destroy
    @comment = comment_find_params_id
    post_id = @comment.post_id
    @comment.destroy
    notice("コメントを削除しました。")
    redirect_to post_path(post_id)
  end

  def comment_params
    params.require(:comment).permit(:comment_word)
  end
end
