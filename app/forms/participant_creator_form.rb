class ParticipantCreatorForm
    include ActiveModel::Model

    attr_accessor :player_id, :player_name, :game, :type
    
    validates :game, presence: true
    validate :player_name_presence
    validate :player_id_presence
    validate :uniqueness_of_player
    validate :quantity_of_players

    def save
        return false unless valid?
        create_and_add_player_to_game if type == 'input'
        add_player_to_game(Player.find(player_id)) if type == 'select'
        true
    end

    private

    def player_name_presence
        return unless type == 'input'
        if player_name.nil? || player_name == '' 
            errors.add(:base, "Please type players name") and return false
        end      
    end

    def player_id_presence
        return unless type == 'select'
        if player_id.nil? || player_name == ''
            errors.add(:base, "Please select a player from list") and return false
        end      
    end

    def uniqueness_of_player
        if Participant.find_by(game_id: game, player_id: player_id).present?
            errors.add(:base, "That player was already added") and return false
        end   
    end

    def quantity_of_players
        if game.participants.count == 6
            errors.add(:base, "You can't add another player") and return false
        end
    end

    def create_and_add_player_to_game
        new_player = Player.create(name: player_name)
        add_player_to_game(new_player)
    end

    def add_player_to_game(player)
        Participant.create(player_id: player.id, game_id: game.id)
    end
end