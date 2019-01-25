class User < ActiveRecord::Base
    has_secure_password validations: false
    
    validates :nickname, presence: true
    validates :nickname, uniqueness: true

    has_many :participants
    has_many :games, through: :participants
    has_many :invitations

    enum status: {
        not_active: 0,
        active: 10
    }    
end