class GamesStartController< ApplicationController
    def update
        @form = GameStarterForm.new(game: game)
        binding.pry
        if @form.valid?
            @form.start
            redirect_to games_path
        else
            redirect_to new_game_participant_path(game)
        end
    end

    private

    def game
        @game ||= Game.find(params[:id])
    end
end
