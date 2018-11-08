FactoryBot.define do
    factory :game, class: Game do
        sequence(:title) { |n| "game#{n}" }
    end
end