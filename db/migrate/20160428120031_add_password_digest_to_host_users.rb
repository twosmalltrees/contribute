class AddPasswordDigestToHostUsers < ActiveRecord::Migration
  def change
    add_column :host_users, :password_digest, :string
  end
end
