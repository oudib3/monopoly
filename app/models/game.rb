class Game < ActiveRecord::Base
    has_many :participants, dependent: :destroy
    has_many :users, through: :participants
    has_many :invitations
    
    enum status: {
        created: 0,
        in_progress: 10,
        finished: 20
    }
end