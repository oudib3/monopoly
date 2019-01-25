FactoryBot.define do
    factory :user, class: User do
        sequence(:email) { |n| "user#{n}@user.pl" }
        sequence(:nickname) { |n| "nickname#{n}" }
        sequence(:password) {|n| "gowno#{n}"}
        sequence(:password_confirmation){|n| "gowno#{n}"}
    end
end