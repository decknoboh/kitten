class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  with_options presence: true do
    validates :comment_word
  end

  def get_comment_date
    created_at.strftime('%Y/%m/%d %H:%M')
  end

  def get_comment_word
    if comment_word.length > 10
      word = comment_word.slice(0..10)
      word + "..."
    else
      comment_word
    end
  end

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
