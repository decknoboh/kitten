class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @posts = Post.page(params[:page]).per(30).order(id: "DESC")
  end
end
