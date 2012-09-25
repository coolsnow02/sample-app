class Micropost < ActiveRecord::Base
  attr_accessible :content, :user_id
   has_many :comments
  belongs_to :user

  def self.from_users_followed_by(user)
    followed_ids = user.following.map(&:id).join(", ")
    where("user_id IN (#{followed_ids}) OR user_id = ?", user)
  end

end
