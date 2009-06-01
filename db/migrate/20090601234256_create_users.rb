class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :hashed_password
      t.string :salt
      t.boolean :can_has_notifications
      t.integer :uid
      t.string :uname
      t.integer :rid
      t.string :novel_title
      t.boolean :is_admin

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
