class Post < ApplicationRecord
  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :image
  acts_as_taggable_on :tags
  
  with_options presence: true do
    validates :title
    validates :posts_comment
  end

  def get_post_image_wide_height(width, height)

    upload_default_image unless image.attached?
    image.variant(resize_to_limit: [width, height]).processed
  end

  def get_show_post_image(size)
    upload_default_image unless image.attached?
    image.variant(resize: size).processed
  end

  def get_image
    upload_default_image unless image.attached?
    image.variant( resize: "100x100^" ).processed
  end

  def upload_default_image
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end

  def get_posted_date
    created_at.strftime('%Y/%m/%d %H:%M')
  end

  def favorited?(user)
    favorites.where(user_id: user.id).exists?
  end
end
