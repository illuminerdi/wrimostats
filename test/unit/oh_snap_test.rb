require 'test_helper'

class OhSnapTest < ActiveSupport::TestCase
  fixtures :all

  should_belong_to :user
  should_belong_to :word_war
  should_validate_presence_of :word_war_id, :user_id, :comment

  context "a new Oh Snap" do
    setup do
      @oh_snap = OhSnap.new({:word_war_id => word_wars(:two).to_param, :comment => "Simple comment"})
    end

    should "not allow snaps from a user not part of this word war" do
      @oh_snap.user_id = users(:reid).to_param
      assert ! @oh_snap.valid?
    end

    should "not allow snaps from a user who is not a willing participant" do
      @oh_snap.user_id = users(:one).to_param
      assert ! @oh_snap.valid?
    end
  end
end
