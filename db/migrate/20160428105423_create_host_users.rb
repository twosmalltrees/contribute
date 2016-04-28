class CreateHostUsers < ActiveRecord::Migration
  def change
    create_table :host_users do |t|

      t.timestamps null: false
    end
  end
end
