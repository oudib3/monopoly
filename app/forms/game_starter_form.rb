class GameStarterForm
    include ActiveModel::Model

    attr_accessor :game

    validate :quantity_of_players
    validate :not_started

    def start
        game.in_progress!
    end

    private

    def not_started
       return if game.created?
       errors.add(:base, "Game is already in progress or it's over")
    end

    def quantity_of_players
        if game.participants.size > 6
            errors.add(:base, "There is too many players") and return false
        end
        if game.participants.size < 2
            errors.add(:base, "At least 2 players are needed to start the game") and return false
        end
    end
end