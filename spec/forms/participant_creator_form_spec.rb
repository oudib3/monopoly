require 'rails_helper'

describe ParticipantCreatorForm do
    let(:form) {described_class.new(params)}
    let(:call) {form.save}
    let(:type) { 'input' }
    let(:params) {{player_id: player.id, player_name: player.name, game: game, type: type}}
    let(:player) {create(:player)}
    let(:game) {create(:game)}
    let(:participant) {{game_id: game.id, player_id: player.id}}

    context "participants with valid params" do
        context "when type is input" do
            it "saves" do
                expect(call).to eq true
            end
        end

        context "when type is select" do

            let(:type) { 'select' }

            it "saves" do
                expect(call).to eq true
            end

                context "and there is a room for new player" do
                    it "saves" do 
                    end
                end
        end
    end

    context "participant with invalid params" do
        context "when type is input" do
            
            let(:params) {{player_id: nil, player_name: '', game: game, type: type}}
            let(:type) { 'input' }
            it "does not save" do
                expect(call).to eq false
            end
        end

        context "when type is select" do

            let(:params) {{player_id: nil, player_name: '', game: game, type: type}}
            let(:type) { 'select' }

            it "does not save" do
                expect(call).to eq false
            end

            context "and there is no room for new player" do
                before do
                    6.times {create(:participant,game_id: game, player_id: player)}
                end
                
                it "does not save" do
                    expect(call).to eq false
                end

                it "should add error to form" do
                    expect(form.errors).to include("You can't add another player")
                end
            end
        end
    end
end