class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new , :create, :update, :edit ,:destroy]

  def index
    @posts = Post.page(params[:page]).per(10).order(id: "DESC")
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}").page(params[:page]).per(10).order(id: "DESC")
    elsif params["model"]  == 'post'
      key_word =  "%#{ActiveRecord::Base.sanitize_sql_like(params[:word].to_s)}%"
      @posts = Post.where("title like ? or posts_comment like ? ", key_word, key_word).page(params[:page]).per(10).order(id: "DESC")
    elsif params["model"]  == 'user'。
      key_word =  "%#{ActiveRecord::Base.sanitize_sql_like(params[:word].to_s)}%"
      @posts =  Post.joins(:user).where("users.name like ?", key_word).page(params[:page]).per(10).order(id: "DESC")
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      notice("投稿完了しました。")
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def show
    @post = post_find_params_id
    @comment = Comment.new
  end

  def edit
    @post = post_find_params_id
  end

  def update
    @post = post_find_params_id
    if @post.update(post_params)
      notice("投稿内容を更新しました。")
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = post_find_params_id
    @post.destroy
    notice("投稿内容を削除しました。")
    redirect_to user_posts_path(current_user.id)
  end

  private
  
  def post_params
    params.require(:post).permit(:image, :title, :posts_comment, :tag_list)
  end
end
