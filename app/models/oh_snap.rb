class OhSnap < ActiveRecord::Base
  belongs_to :word_war
  belongs_to :user

  validates_presence_of :user_id, :word_war_id, :comment
end
