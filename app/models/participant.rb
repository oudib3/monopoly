class Participant < ActiveRecord::Base
    belongs_to :game, counter_cache: true
    belongs_to :user

    
end