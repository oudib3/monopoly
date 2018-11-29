class CreateInvitations < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.string :inviter
      t.string :invited
      t.integer :game_id
      t.belongs_to :user
      t.timestamps
    end
  end
end
