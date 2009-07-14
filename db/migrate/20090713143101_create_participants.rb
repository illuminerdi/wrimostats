class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.integer :word_war_id
      t.integer :user_id
      t.boolean :is_willing, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :participants
  end
end
