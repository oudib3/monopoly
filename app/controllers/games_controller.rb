class GamesController < ApplicationController
    def index
        @games = Game.all
    end
    
    def new

    end

    def create
        @form = GameCreatorForm.new(game_params)
        if @form.save
            redirect_to user_path(current_user)
        else
            render new_game_path
        end
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

    def edit
        game
    end
    def destroy
        Game.find(game.id).destroy
        redirect_to games_path
    end

    private

    def game
        @game ||= Game.find(params[:id])
    end

    def game_params
        params.permit(:title).merge(user: current_user)
    end
end