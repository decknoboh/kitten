class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def get_post_title(post_id)
    Post.where(id: post_id).pluck(:title)[0]
  end

  def get_post_user_id(post_id)
    Post.where(id: post_id).pluck(:user_id)[0]
  end

  def get_post_user_name(post_id)
    post_user_id = get_post_user_id(post_id)
    User.where(id: post_user_id).pluck(:name)[0]
  end
end
