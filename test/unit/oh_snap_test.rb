require 'test_helper'

class OhSnapTest < ActiveSupport::TestCase
  fixtures :all

  should_belong_to :user
  should_belong_to :word_war
end
