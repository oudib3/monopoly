class AddGameMasterToParticipants < ActiveRecord::Migration[5.1]
  def change
    add_column :participants, :game_master, :boolean
  end
end
