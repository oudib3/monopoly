require 'rails_helper'

RSpec.describe SignInForm do
    let(:form) {described_class.new(params)}
    let(:params) {{email: email, password: password}}
    let(:call) {form.valid?}
    let(:user) {create(:user)}
    let(:password) {user.password}
    let(:email) {user.email}

    context 'input with valid params' do
        
        context 'when user exists' do
            context 'and valid credentials' do
                it 'returns user' do
                    expect(call).to eq true
                    expect(form.user).to eq(user)
                end
            end

            context 'and invalid credentials' do
                let(:user){create(:user)}
                let(:password){'badpassword'}
                it 'dont returns user and add error to form' do
                    expect(call).to eq(false)
                    expect(form.errors[:base]).to include("Invalid Credentials")
                end
            end
        end    
    end

    context 'input with invalid' do
        let(:params){{email: 'wrongemail', password: 'wronpassword'}}
        it 'returns error' do
            expect(call).to eq false
            expect(form.errors.full_messages).to include("Invalid Credentials")
        end

        context 'email' do
            context 'format' do
                let(:params){{email: 'wrongemail', password: 'wronpassword'}}
                it 'returns error' do
                    expect(call).to eq false
                    expect(form.errors.full_messages).to include("Email is invalid")
                end
            end

            context 'presence' do
                let(:params){{email: '', password: 'wronpassword'}}
                it 'returns error' do
                    expect(call).to eq false
                    expect(form.errors.full_messages).to include("Email can't be blank")
                end
            end
        end

        context 'password' do
            context 'presence' do
                let(:params){{email: 'wrongemail', password: ''}}
                it 'returns error' do
                    expect(call).to eq false
                    expect(form.errors.full_messages).to include("Password can't be blank")
                end
            end
        end
    end
end