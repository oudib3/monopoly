FactoryBot.define do
    factory :user, class: User do
        sequence(:email) { |n| "user#{n}@user.pl" }
        sequence(:nickname) { |n| "nickname#{n}" }
    end
end