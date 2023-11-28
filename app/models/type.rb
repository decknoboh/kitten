class Type < ApplicationRecord
  has_one_attached :image
  acts_as_taggable_on :tags

  with_options presence: true do

    validates :name
    validates :body_length
    validates :country
    validates :detail
  end

  def get_image(size)
    upload_default_image unless image.attached?
    image.variant(resize: size).processed
  end

  def upload_default_image
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end

  def get_posted_date
    created_at.strftime('%Y/%m/%d %H:%M')
  end
end
