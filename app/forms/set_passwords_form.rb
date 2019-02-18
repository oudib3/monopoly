class SetPasswordsForm
    include ActiveModel::Model

    attr_accessor :password, :password_confirmation, :user, :token

    validates :password, :password_confirmation, presence: true
    validates :password, confirmation: true
    validate :invitation_presence

    def save
        return false unless valid? 
        set_password
        true
    end

    private

    def invitation_presence
        return unless Invitation.where(user_id: user.id, token: token).present?
        errors.add(:base, "Invalid Params")
    end

    def set_password
        user.password = password
        user.password_confirmation = password_confirmation
        user.save
        user.active!
    end

end