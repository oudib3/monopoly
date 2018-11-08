class GamesController < ApplicationController
    def index
        @games = Game.all
    end
    
    def create
        Game.create()
        redirect_to games_path
    end

    # def update
    #     binding.pry
    #     @form = GameUpdateForm.new(game: game)
    #     if @form.save
    #         #TODO redirect_to game_path
    #     else
    #         redirect_to new_game_participant_path(game)
    #     end
    # end

    def destroy
        Game.find(game.id).destroy
        redirect_to games_path
    end

    private

    def game
        @game ||= Game.find(params[:id])
    end
end