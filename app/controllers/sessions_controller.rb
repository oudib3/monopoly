class SessionsController < ApplicationController
    def new
    end

    def create
        @form = SignInForm.new(user_params)
        if @form.valid?
            session[:current_user_id] = @form.user.id
            redirect_to user_path(@form.user.id)
        else 
            render new_session_path
        end
    end

    private

    def user_params
        params.require(:session).permit(:email, :password)
    end
end