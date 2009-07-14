require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  FakeWeb.allow_net_connect = false
  reid = File.expand_path(File.dirname(__FILE__)) + "/../fixtures/xml/user_245095_wc.xml"
  FakeWeb.register_uri("http://www.nanowrimo.org/wordcount_api/wc/245095", :file => reid)
  bad = File.expand_path(File.dirname(__FILE__)) + "/../fixtures/xml/user_wc_error.xml"
  FakeWeb.register_uri("http://www.nanowrimo.org/wordcount_api/wc/999999", :file => bad)

  fixtures :all

  should_belong_to :word_war
  should_validate_presence_of :uid, :word_war_id
  should_validate_uniqueness_of :uid, :scoped_to => :word_war_id, :message => /That Nanowrimo ID is already part of this Word War/

  context "a Participant instance" do
    setup do
      @participant = participants(:one)
    end

    should "return false when given a bad UID" do
      @participant.uid = 999999
      assert ! @participant.valid?
      assert @participant.errors.on(:uid)
    end

    should "return true when given a proper UID" do
      assert @participant.valid?
    end

    should "load user data from nanowrimo when asked for it" do
      assert @participant.respond_to?(:nano_data)
      assert @participant.nano_data
      assert @participant.nano_data.instance_of?(Hash)
      assert_equal @participant.uid, @participant.nano_data[:uid]
    end
  end
end
