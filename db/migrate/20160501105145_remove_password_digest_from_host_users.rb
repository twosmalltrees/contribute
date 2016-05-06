class RemovePasswordDigestFromHostUsers < ActiveRecord::Migration
  def change
    remove_column :host_users, :password_digest
  end
end
