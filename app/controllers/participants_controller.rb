class ParticipantsController < ApplicationController
    def new
        game
    end

    def create
        @form = ParticipantCreatorForm.new(participant_params)
        if @form.save
            redirect_to new_game_participant_path(game)
        else
            render :new
        end
    end

    def destroy
        Participant.find(params[:id]).destroy
        redirect_to new_game_participant_path
    end

    private
    def participant_params
        params.permit(:player_name, :player_id, :type).merge!(game: game)
    end
    
    def game
        @game ||= Game.find(params[:game_id])
    end
end