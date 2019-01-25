class SessionsController < ApplicationController
    def new
        if current_user.present?
            redirect_to user_path(current_user)
        end
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

    def destroy
        session.delete(:current_user_id)
        redirect_to root_path
    end

    private

    def user_params
        params.require(:session).permit(:email, :password)
    end
end