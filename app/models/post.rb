class Post < ActiveRecord::Base
  attr_accessible :body, :user_id

  belongs_to :user

  validates :user, :body, presence: true

  default_scope order('created_at DESC')
end
