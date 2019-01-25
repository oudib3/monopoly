require 'rails_helper'

RSpec.describe SignUpForm do
    let(:call) {form.save}
    let(:form) {described_class.new(params)}
    let(:params) {{email: user.email, nickname: nickname, password: user.password, password_confirmation: user.password}}
    let(:user){create(:user)}
    let(:nickname) {user.email.match(/(.+)@/)[1]}
    
    context "User with valid params" do
        it 'saves' do
            expect(call).to eq true
        end
    end

    context "User with invalid" do

        context "email presence" do
            let(:params) {{
                email: '',
                nickname: nickname,
                password: user.password,
                password_confirmation: user.password
                }}
            it 'dont save' do
                expect(call). to eq false
            end
        end
        context "email format" do
            let(:params) {{
                email: 'bad-email',
                nickname: nickname,
                password: user.password,
                password_confirmation: user.password,
                }}
            it 'dont save' do
                expect(call). to eq false
            end
        end
        context "password presence" do
            let(:params) {{
                email: user.email,
                nickname: nickname,
                password: '',
                password_confirmation: '',
                }}
            it 'dont save' do
                expect(call). to eq false
            end
        end
        context "password confirmation presence" do
            let(:params) {{
                email: user.email,
                nickname: nickname,
                password: user.password,
                password_confirmation: '',
                }}
            it 'dont save' do
                expect(call). to eq false
            end
        end
    end
    context "password confirmation match" do
        let(:params) {{
            email: user.email,
            nickname: nickname,
            password: user.password,
            password_confirmation: 'wrong confirmation',
            }}
        it 'dont save' do
            expect(call). to eq false
        end
    end
end