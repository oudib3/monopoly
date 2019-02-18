class AddEmailToInvitations < ActiveRecord::Migration[5.1]
  def change
    add_column :invitations, :email, :string
  end
end
