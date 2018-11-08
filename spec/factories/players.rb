FactoryBot.define do
    factory :user, class: User do
        sequence(:name) { |n| "player#{n}" }
    end
end