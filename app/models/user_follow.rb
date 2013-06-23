class UserFollow < ActiveRecord::Base
  attr_accessible :follower_id, :user_id

  belongs_to :user
  belongs_to :follower, class_name: "User"

  validates :follower, :user, presence: true
  validate :not_following_self

  private
  def not_following_self
    if user_id == follower_id
      errors[:user] = " cannot follow youself"
    end
  end
end
