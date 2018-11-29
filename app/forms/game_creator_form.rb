class GameCreatorForm
    include ActiveModel::Model

    attr_accessor :title, :user

    validates :title, presence: true

    def save
        return unless valid?
        create_game
        add_game_master
        true
    end

    private

    def create_game
        @game ||= Game.create(title: game_title)
    end

    def add_game_master
        Participant.create(game_id: @game.id, user_id: user.id, game_master: true)
    end

    def game_title
        game_title = "#{user.nickname} - #{title}"
    end
end