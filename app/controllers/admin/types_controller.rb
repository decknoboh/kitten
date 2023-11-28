class Admin::TypesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @types = Type.page(params[:page]).per(30).order(id: "DESC")
  end

  def new
    @type = Type.new
  end

  def create
    @type = Type.new(type_params)
    if @type.save
      notice("ずかんを追加しました。")
      redirect_to admin_type_path(@type.id)
    else
      render :new
    end
  end

  def show
    @type = type_find_params_id
  end

  def edit
    @type = type_find_params_id
  end

  def update
    @type = type_find_params_id
    if @type.update(type_params)
      notice("ずかんを更新しました。")
      redirect_to admin_type_path(@type.id)
    else
      render :edit
    end
  end

  def destroy
    type = type_find_params_id
    type.destroy
    notice("ずかんから１件削除しました。")
    redirect_to admin_types_path
  end

  private

  def type_params
    params.require(:type).permit(:image,:name,:body_length,:country,:tag_list,:detail)
  end
end
