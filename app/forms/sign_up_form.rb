class SignUpForm
    include ActiveModel::Model

    attr_accessor :email, :nickname, :password, :password_confirmation
    attr_reader :user
    
    validates :password, confirmation: true
    validates :password_confirmation, presence: true
    validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, presence: true
    
    def save
        return false unless valid?
        create_user
        true
    end
    
    private
    
    def create_user
        @user = User.create(email: email.downcase,
                nickname: nickname, 
                password: password, 
                password_confirmation: password_confirmation
                )
    end
end