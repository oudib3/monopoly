class ParticipantCreatorForm
    include ActiveModel::Model

    attr_accessor :email, :game
    
    validates :game, :email, presence: true
    validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
    validate :uniqueness_of_player
    validate :quantity_of_players

    def save
        return false unless valid?
            if user.present?
                add_player_to_game(user)
            else
                # new_user = User.create(email: email.downcase, nickname: email.match(/(.+)@/)[1])
                add_player_to_game(new_user)
            end
        true
    end

    private

    def uniqueness_of_player
        return if !user.present?
        if Participant.find_by(game_id: game, user_id: user.id).present?
            errors.add(:base, "That player was already added") and return false
        end
    end

    def quantity_of_players
        if game.participants.count == 6
            errors.add(:base, "You can't add another player") and return false
        end
    end

    def add_player_to_game(player)
        Participant.create(user_id: user.id, game_id: game.id)
    end

    def user
        @user ||= User.find_by(email: email)
    end
end