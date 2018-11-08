class User < ActiveRecord::Base
    has_secure_password
    
    validates :nickname, presence: true
    validates :nickname, uniqueness: true

    has_many :games, through: :participants
end