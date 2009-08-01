class OhSnap < ActiveRecord::Base
  belongs_to :word_war
  belongs_to :user

  validates_presence_of :user_id, :word_war_id, :comment

  validate :user_can_snap_this_word_war

  private

  def user_can_snap_this_word_war
    if user_id
      participations = User.find(user_id).participations
      can_snap = false
      participations.each {|p|
        if p[:word_war_id] == word_war_id && p[:is_willing]
          can_snap = true
        end
      }
      errors.add_to_base("You are not a part of this word war.") unless can_snap
    end
  end
end
