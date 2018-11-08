FactoryBot.define do
    factory :participant, class: Participant do
        sequence(:game_id) { |n| n }
    end
end