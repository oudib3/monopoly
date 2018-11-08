class SignInForm
    include ActiveModel::Model

    attr_accessor :email, :password

    validates :email, :password, presence: true
    validate :user_exists
    

    def user
        @user ||= User.find_by(email: email)&.authenticate[password]
    end

    private

    def user_exists
        return if user.present?
        errors.add(:base, "Invalid Credentials")
    end
end