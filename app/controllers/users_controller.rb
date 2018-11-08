class UsersController < ApplicationController
    def new
    end

    def create
        @form = SignUpForm.new(user_params)
        if @form.save
            redirect_to root_path
        else
            render new_user_path
        end
    end

    def show
        @games ||= current_user.games
    end

    private

    def user_params
        params.permit(:email, :nickname, :password, :password_confirmation)
    end
end