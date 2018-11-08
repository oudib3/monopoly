class Game < ActiveRecord::Base
    has_many :users, through: :participants
    has_many :participants, dependent: :destroy

    enum status: {
        created: 0,
        in_progress: 10,
        finished: 20
    }
end