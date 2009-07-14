require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  fixtures :all

  should_belong_to :word_war
  should_validate_presence_of :uid, :word_war_id, :is_willing
  should_validate_uniqueness_of :uid, :scoped_to => :word_war_id, :message => /That Nanowrimo ID is already part of this Word War/
end
