class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :name
    validates :sex
    validates :email
    validates :self_introduction
  end

  has_one_attached :image
  enum sex: { another: 0, male: 1, famale: 2 }

  def self.guest
    find_or_create_by!(email: 'guest@nekoha.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.name = 'ゲスト'
      user.sex = 0
      user.self_introduction = "ゲストログイン用です。"
      user.is_deleted = false
    end
  end

  def get_profile_image(size)
    upload_default_image unless image.attached?
    image.variant(resize: size).processed
  end

  def upload_default_image
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end

end
