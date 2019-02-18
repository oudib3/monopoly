class SetPasswordsController < ApplicationController
    def edit
        user
        token
    end

    def update
        @form = SetPasswordsForm.new(invitation_params)
        binding.pry
        if @form.save
            redirect_to new_session_path, notice: "password succesfull"
        else
            render :edit
        end
    end

    private

    def user
        @user ||= User.find_by(email: params[:email])
    end

    def invitation_params
        params.permit(:password,:password_confirmation, :token).merge(user: user)
    end 


end