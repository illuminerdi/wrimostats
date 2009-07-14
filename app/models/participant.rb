class Participant < ActiveRecord::Base
  belongs_to :word_war

  validates_presence_of :uid, :word_war_id, :is_willing
  validates_uniqueness_of :uid, :scope => :word_war_id, :message => "That Nanowrimo ID is already part of this Word War."
end
