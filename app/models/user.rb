class User < ApplicationRecord
	has_many :tweets, dependent: :destroy
	has_secure_password
	validates :name, :email, presence: true
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  	has_many :followers, through: :reverse_relationships, source: :follower
	has_many :followed_users, through: :relationships, source: :followed


  def following?(user_id)
    relationships.find_by(followed_id: user_id)
  end

  def follow!(user_id)
    relationships.create!(followed_id: user_id)
  end

  def unfollow!(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
end
