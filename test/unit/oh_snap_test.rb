require 'test_helper'

class OhSnapTest < ActiveSupport::TestCase
  fixtures :all

  should_belong_to :user
  should_belong_to :word_war
  should_validate_presence_of :word_war_id, :user_id, :comment

  context "a new Oh Snap" do
    setup do
      @oh_snap = OhSnap.new({:word_war_id => word_wars(:two), :comment => "Simple comment"})
    end

    should "not allow snaps from a user not part of this word war" do
      @oh_snap.user_id = 245095
      assert ! @oh_snap.valid?
      assert @oh_snap.errors.on(:word_war_id)
    end

    should "not allow snaps from a user who is not a willing participant" do
      @oh_snap.user_id = 123456
      assert ! @oh_snap.valid?
      assert @oh_snap.errors.on(:word_war_id)
    end
  end
end
