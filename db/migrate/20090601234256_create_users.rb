class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :hashed_password
      t.string :salt
      t.boolean :can_has_notifications, :default => true
      t.integer :uid
      t.boolean :is_admin, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
