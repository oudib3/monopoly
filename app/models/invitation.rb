class Invitation < ActiveRecord::Base
    belongs_to :game
    belongs_to :user

    # validates :game_id, uniqueness: {scope: :inviter}

    enum status: {
        pending: 0,
        accepted: 10,
        declined: 20
    }
end