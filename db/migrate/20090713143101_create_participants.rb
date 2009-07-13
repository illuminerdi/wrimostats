class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.integer :word_war_id
      t.integer :uid
      t.boolean :is_willing

      t.timestamps
    end
  end

  def self.down
    drop_table :participants
  end
end
