class Micropost < ActiveRecord::Base
	validates :user_id, presence: true
	validates :content, presence: true, length: {maximum: 140}
	default_scope -> { order('created_at DESC') }
	belongs_to :user

	#def self.from_users_followed_by(user)
	#	followed_user_ids = user.followed_user_ids
	#	where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
	#end

	# Returns microposts from the users being followed by the given user.
	def self.from_users_followed_by(user)
	followed_user_ids = "SELECT followed_id FROM relationships
	WHERE follower_id = :user_id"
	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
	user_id: user.id)
	end

end
