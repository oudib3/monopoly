class InvitationsController < ApplicationController
    before_action :current_user
    before_action :game
    before_action :token, only: :create
    def new
    end

    def create
        @form = InvitationCreatorForm.new(invitation_params.merge(token: token))
        if @form.save
            redirect_to current_user
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
                                            set_password_url: edit_set_password_url,
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