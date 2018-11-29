class InvitationCreatorForm
    include ActiveModel::Model

    attr_accessor :inviter, :email, :game, :token, :session_url, :sign_up_url

    validates :inviter, :email, :game, :token, presence: true
    validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, presence: true
    validate :invitation_pending
    validate :invitation_accepted

    def save
        return false unless valid?
            if user.present?
                create_invitation("existing")
            else
                create_invitation("not_existing")
            end
        true
    end

    private

    def invitation_accepted
        return unless invitations.any? {|inv| inv.accepted? }
            errors.add(:base, "user already accepted invitation")
    end

    def invitation_pending
        return unless invitations.any? {|inv| inv.pending? }
            errors.add(:base, "invitation was already sent")
    end

    def invitations
        @invitations ||= begin
            if  user&.invitations&.present? 
                user.invitations.where(user_id: user.id, game_id: game.id)
            else
                []
            end
        end
    end

    def user
        user ||= User.find_by(email: email)
    end
    
    def url
        [session_url, "token=#{token}"].join('?')
    end

    def create_invitation(type)
        case type
        when 'existing' then
            Invitation.create(game_id: game.id, 
                                user_id: user.id,
                                inviter: inviter,
                                email: email,
                                token: token
                            )
            # InvitationMailer.send_invitation_for_existing(email, inviter, url).deliver_now

        when 'not_existing' then 
            new_user = User.create(email: email.downcase, nickname: email.match(/(.+)@/)[1])
            Invitation.create(game_id: game.id, 
                                user_id: new_user.id,
                                inviter: inviter,
                                email: email,
                                token: token
                            )
            # InvitationMailer.send_invitation_for_not_existing(email, current_user, sign_up_url)
            #                 .deliver_now

        else
        end
    end
end