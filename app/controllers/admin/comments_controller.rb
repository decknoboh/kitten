class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = Comment.page(params[:page]).per(30).order(id: "DESC")
  end

  def destroy
    comments = comment_find_params_id
    comments.destroy
    notice("コメントを削除しました。")
    redirect_to admin_comments_path
  end
end
