class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @post = post_find_params_id
  end

  def destroy
    @post = post_find_params_id
    @post.destroy
    notice("投稿内容を削除しました。")
    redirect_to admin_home_top_path
  end
end
