require 'test_helper'

class OhSnapTest < ActiveSupport::TestCase
  fixtures :all

  should_belong_to :user
  should_belong_to :word_war
  should_validate_presence_of :word_war_id, :user_id, :comment
end
