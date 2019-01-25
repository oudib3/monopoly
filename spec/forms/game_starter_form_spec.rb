require 'rails_helper'

RSpec.describe GameStarterForm do
    let(:game){create(:game)}
    let(:call) {form.valid?}
    let(:form) {described_class.new(params)}
    let(:params){{game: game}}
    
    context "game with allowed quantity of players " do
        before do
            create(:user)
            create(:user)
            game.participants << create(:participant,game_id: game.id, user_id: User.first.id)
            game.participants << create(:participant,game_id: game.id, user_id: User.second.id)
            game.save!
        end
        it 'is valid' do
            expect(call).to eq true
        end
    end

    context "game with not allowed quantity of players " do
        before do
            create(:user)
            game.participants << create(:participant,game_id: game.id, user_id: User.first.id)
            game.save!
        end
        it 'is invalid' do
            expect(call).to eq false
            expect(form.errors.full_messages).to include("There is too many players")
            .or include('At least 2 players are needed to start the game')
        end
    end
end