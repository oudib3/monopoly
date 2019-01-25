class SetPasswordsController < ApplicationController
    def edit
        user
        token
    end

    def update
        binding.pry
        @form = SetPasswordsForm.new(invitation_params)
        if @form.save
            redirect_to new_session_path, notice: "password succesfull"
        else
            render :new
        end
    end

    private

    def user
        @user ||= User.find_by(email: params[:email])
    end

    def token
        @token ||= params[:token]
    end

    def invitation_params
        params.permit(:password,:password_confirmation).merge
    end 
end