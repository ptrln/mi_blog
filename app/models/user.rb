class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :username, :password, :password_confirmation, :remember_me

  has_many :posts, :dependent => :destroy
  has_many :user_follows, :dependent => :destroy
  has_many :followers, through: :user_follows, source: :follower
  has_many :user_following, class_name: "UserFollow", foreign_key: :follower_id, :dependent => :destroy
  has_many :following, through: :user_following, source: :user

  validates :username, uniqueness: true, presence: true

  def to_param
    username
  end

  def following_posts
    ids = following_ids << self.id
    p (ids)
    Post.where("user_id IN (?)", ids).all
  end
end
