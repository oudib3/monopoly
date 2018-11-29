class DeleteInvitedFromInvitations < ActiveRecord::Migration[5.1]
  def change
    remove_column :invitations, :invited, :string
  end
end
