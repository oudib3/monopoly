FactoryBot.define do
    factory :user, class: User do
        sequence(:email) { |n| "user#{n}@user.pl" }
        sequence(:nickname) { |n| "nickname#{n}" }
        sequence(:password) {|n| "pass#{n}"}
        sequence(:password_confirmation){|n| "pass#{n}"}
    end
end