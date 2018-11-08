class AddParticipantsCountToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :participants_count, :integer
  end
end
