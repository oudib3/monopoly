require "rails_helper"

RSpec.describe InvitationCreatorForm do

    let(:form) {described_class.new(params)}
    let(:call) {form.save}
    let(:params) {{inviter: inviter, email: user.email, game: game, token: token, session_url: session_url, sign_up_url: sign_up_url}}
    let(:user) {create(:user)}
    let(:game) {create(:game)}
    let(:token) {SecureRandom.uuid}
    let(:session_url) {"/sessions/new"}
    let(:sign_up_url) {"/users/new"}
	let(:inviter) {'dano@dano.pl'}

	context "invitations with valid email" do
		context "when user exist" do
			context "and user dont have invitation" do
				it "saves" do
    				expect(call).to eq true
    			end
    		end
    	end

    	context "when user get invitation" do
			context "and accepted it" do
				before do 
					create(:invitation, user_id: user.id, game_id: game.id, status: 'accepted')
				end

    			it "do not saves" do
    				expect(call).to eq false
    			end
    		end

			context "and declined it" do
				before do
					create(:invitation, user_id: user.id, game_id: game.id, status: 'declined')
				end

    			it "saves" do
    				expect(call).to eq true
    			end 
    		end

			context "and invitation pending" do
				before do
					create(:invitation, user_id: user.id, game_id: game.id, status: 'pending')
				end

    			it "do not saves" do
    				expect(call).to eq false
    			end 
    		end
    	end

		context "when user don't exist" do
			let(:user) {build(:user)}
			
			it "saves" do
				expect(call).to eq true
    		end    		
    	end
    end

	context "invitations with invalid email" do
		let(:params) {{inviter: inviter, email: 'wrongemail.xd', game: game, token: token, session_url: session_url, sign_up_url: sign_up_url}}

		it "do not saves" do
			expect(call).to eq false
    	end
    end    
end