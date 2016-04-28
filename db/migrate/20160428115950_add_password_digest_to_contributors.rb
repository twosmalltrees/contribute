class AddPasswordDigestToContributors < ActiveRecord::Migration
  def change
    add_column :contributors, :password_digest, :string
  end
end
