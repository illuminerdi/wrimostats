class WordWar < ActiveRecord::Base
  validates_presence_of :title, :user_id
  validates_uniqueness_of :title, :scope => :user_id, :message => "You already have a Word War with that title."

  belongs_to :user
  has_many :participants
end
