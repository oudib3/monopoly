class InvitationMailer < ActionMailer::Base
    default from: 'notifications@oudismonopoly.com'
    
    def send_invitation_for_existing(email, inviter, url)
        @email = email
        @inviter = inviter
        @url = url
        mail(to: @email, subject: 'invitation')
    end
    
    def send_invitation_for_not_existing(email, inviter, url)
        @email = email
        @inviter = inviter
        @url = url
        mail(to: @email, subject: 'sing-up')
    end
end