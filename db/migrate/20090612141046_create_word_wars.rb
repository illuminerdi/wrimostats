class CreateWordWars < ActiveRecord::Migration
  def self.up
    create_table :word_wars do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.boolean :can_has_snaps, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :word_wars
  end
end
