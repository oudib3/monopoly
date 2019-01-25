require 'rails_helper'

RSpec.describe GameCreatorForm do
    let(:call) { form.save }
    let(:form) {described_class.new(params)}
    let(:params) {{title: game.title, user: user}}
    let(:user) {create(:user, email: 'user1@user.pl', nickname: 'nickname1')}
    let(:game) {build(:game, title: 'game1')}

    context 'game with valid title' do
        context 'and there is no game with exact title' do
            it 'saves' do
            expect(call).to eq true
            end
        end

        # TITLE PATTERN : "usernickname-gametitle"
        context 'and there is a game with exact title' do
            before do
                build(:user)
                user.games << build(:game, title: 'nickname1-game1')
                user.save!
            end

            it 'dont save' do
                expect(call).to eq false
            end
        end
    end

    context 'game with invalid title' do
        let(:params) {{title: '', user: user}}
        
        it 'dont save' do
            expect(call).to eq false
        end
    end
end