class User < ApplicationRecord
	has_many :active_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
	has_many :passive_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
	has_many :followers, through: :passive_relationshipus, source: :follower
	has_many :following, through: :active_relationships, source: :followed

	def follow!(other_user)
		active_relationships.create!(followed_id: other_user.id)
	end

	def following?(other_user)
		active_relationships.find_by(followed_id: other_user.id)
	end

	def unfollow!(other_user)
		active_relationships.find_by(followed_id: other_user.id).destory
	end
end
