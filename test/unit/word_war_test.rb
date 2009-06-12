require 'test_helper'

class WordWarTest < ActiveSupport::TestCase
  fixtures :all

  should_validate_uniqueness_of :title, :scoped_to => :user_id, :message => /You already have a word war with that title/i
  should_validate_presence_of :title, :user_id
  should_belong_to :user
end
