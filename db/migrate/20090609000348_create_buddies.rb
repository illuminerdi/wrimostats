class CreateBuddies < ActiveRecord::Migration
  def self.up
    create_table :buddies do |t|
      t.integer :user_id
      t.integer :uid

      t.timestamps
    end
  end

  def self.down
    drop_table :buddies
  end
end
