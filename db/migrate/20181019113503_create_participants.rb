class CreateParticipants< ActiveRecord::Migration[5.1]
  def change
    create_table :participants do |t|
      t.belongs_to :game
      t.belongs_to :user
    end
    add_index :participants, [:game_id, :user_id], unique: true
  end
end
