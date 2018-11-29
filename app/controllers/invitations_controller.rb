class InvitationsController < ApplicationController
    before_action :current_user
    before_action :game
    before_action :token, only: :create
    def new
    end

    def create
        @form = InvitationCreatorForm.new(invitation_params.merge(token: token))
        if @form.save
            redirect_to (params[:game_id])
        else
            render :new
        end
    end

    def edit
        game
    end
    private

    def invitation_params
        params.permit(:inviter, :email).merge(game: game,
                                            session_url: session_url,
                                            sign_up_url: new_user_url
                                            )
    end

    def game
        @game ||= Game.find(params[:game_id])
    end

    def token
        token ||= SecureRandom.uuid
    end
end