class CreateOhSnaps < ActiveRecord::Migration
  def self.up
    create_table :oh_snaps do |t|
      t.integer :word_war_id
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :oh_snaps
  end
end
