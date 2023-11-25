class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for(resource)
    case resource
    when :admin then
      new_admin_session_path
    when :user then
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
        keys: [
          :name,
          :email,
          :self_introduction,
          :encrypted_password
        ]
    )
  end


  public

  def user_find
    User.find(current_user.id)
  end

  def user_find_params_id
    User.find(params[:id])
  end

  def post_find_params_id
    Post.find(params[:id])
  end

  def comment_find_params_id
    Comment.find(params[:id])
  end

  def type_find_params_id
    Type.find(params[:id])
  end

  def notice(msg)
    flash[:notice] = msg
  end

  def alert(msg)
    flash[:alert] = msg
  end

  def get_name(user_id)
    User.where(id: user_id).pluck(:name)[0]
  end
end
