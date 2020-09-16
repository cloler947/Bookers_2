class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :name, presence: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #フォロワー取得
  has_many :following_user, through: :follower, source: :followed #自分がフォローしてる
  has_many :follower_user, through: :followed, source: :follower #自分をフォローしている人

# ユーザーをフォローする
def follow(user_id)
  follower.create(followed_id: user_id)
end

# ユーザーをフォロー解除する
def unfollow(user_id)
  follower.find_by(followed_id: user_id).destroy
end

# 現在のユーザーがフォローしていたらtrueを返す
def following?(user)
  following.include?(user)
end


end
