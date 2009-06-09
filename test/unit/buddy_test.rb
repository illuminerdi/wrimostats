require 'test_helper'

class BuddyTest < ActiveSupport::TestCase
  FakeWeb.allow_net_connect = false
  reid = File.expand_path(File.dirname(__FILE__)) + "/../fixtures/xml/user_245095_wc.xml"
  FakeWeb.register_uri("http://www.nanowrimo.org/wordcount_api/wc/245095", :file => reid)
  renda = File.expand_path(File.dirname(__FILE__)) + "/../fixtures/xml/user_94450_wc.xml"
  FakeWeb.register_uri("http://www.nanowrimo.org/wordcount_api/wc/94450", :file => renda)
  me = File.expand_path(File.dirname(__FILE__)) + "/../fixtures/xml/user_wc.xml"
  FakeWeb.register_uri("http://www.nanowrimo.org/wordcount_api/wc/240659", :file => me)
  bad = File.expand_path(File.dirname(__FILE__)) + "/../fixtures/xml/user_wc_error.xml"
  FakeWeb.register_uri("http://www.nanowrimo.org/wordcount_api/wc/999999", :file => bad)

  fixtures :all

  should_validate_uniqueness_of :uid, :scoped_to => :user_id
  should_validate_presence_of :user_id, :uid
  should_belong_to :user

  context "A Buddy instance" do
    setup do
      @buddy = buddies(:one)
    end

    should "return false when sent #valid_uid?" do
      @buddy.uid = 999999
      assert ! @buddy.valid?
      assert @buddy.errors.on(:uid)
    end
  end
end
