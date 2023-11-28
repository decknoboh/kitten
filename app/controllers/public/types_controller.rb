class Public::TypesController < ApplicationController
  def index
    @types = Type.page(params[:page]).per(10).order(id: "DESC")
    if params[:tag_name]
      @types = Type.tagged_with("#{params[:tag_name]}").page(params[:page]).per(10).order(id: "DESC")
    elsif params[:word]
      key_word =  "%#{ActiveRecord::Base.sanitize_sql_like(params[:word].to_s)}%"
      @types = Type.where("name like ? or body_length like ? or country like ? or detail like ?", key_word, key_word, key_word, key_word).page(params[:page]).per(10).order(id: "DESC")
    end
  end

  def show
    @type = type_find_params_id
  end
end
