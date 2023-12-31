class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit ,:update, :unsubscribe, :goodbye ,:my_page]

  def show
    @user = user_find_params_id
  end

  def my_page
    @user = user_find
  end

  def edit
    @user = user_find
  end

  def update
    @user = user_find
    if @user.update(user_params)
      notice("プロフィールを更新しました。")
      redirect_to my_page_path
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def goodbye
    @user = user_find
    @user.update(is_deleted: true)
    reset_session
    notice("退会完了いたしました。またのご利用お待ちしております。")
    redirect_to root_path
  end

  def posts
    userID = params[:user_id]
    @posts = Post.where(user_id: userID).page(params[:page]).per(10).order(id: "DESC")
    @user_name = get_name(userID)
  end

  def comments
    userID = params[:user_id]
    @comments = Comment.where(user_id: userID).page(params[:page]).per(10).order(id: "DESC")
    @user_name = get_name(userID)
  end

  def favorites
    userID = params[:user_id]
    @favorite = Favorite.where(user_id: userID).page(params[:page]).per(10).order(id: "DESC")
    @user_name = get_name(userID)
  end

  private

  def user_params
    params.require(:user).permit(:name,:sex,:email,:self_introduction,:image)
  end
end
