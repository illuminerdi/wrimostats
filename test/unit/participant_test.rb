require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  fixtures :all

  should_belong_to :word_war
  should_belong_to :user

end
