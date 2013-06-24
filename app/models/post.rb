class Post < ActiveRecord::Base
  attr_accessible :title, :body, :user_id

  belongs_to :user

  validates :title, :user, presence: true

  default_scope order('created_at DESC')
end
