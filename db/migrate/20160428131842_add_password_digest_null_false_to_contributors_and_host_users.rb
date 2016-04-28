class AddPasswordDigestNullFalseToContributorsAndHostUsers < ActiveRecord::Migration
  def change
    change_column :host_users, :password_digest, :string, null: false
    change_column :contributors, :password_digest, :string, null: false
  end
end
