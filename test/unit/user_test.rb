require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    FakeWeb.allow_net_connect=false
    file = File.expand_path(File.dirname(__FILE__)) + "/../fixtures/xml/user_wc.xml"
    FakeWeb.register_uri("#{Nanowrimo::API_URI}/wc/240659", :file => file)
    FakeWeb.register_uri("#{Nanowrimo::API_URI}/wc/123456", :file => file)
    FakeWeb.register_uri("#{Nanowrimo::API_URI}/wc/94450", :file => file)
  end

  should_have_many :buddies
  should_have_many :word_wars
  should_have_many :oh_snaps

  test "user has a name" do
    user = users(:one)
    user.name = ""
    assert ! user.valid?
    assert user.errors.on(:name)
  end

  test "user name is unique" do
    user = User.new(
      :name => users(:one).name,
      :hashed_password => "funny?",
      :salt => "no, stupid"
    )
    assert ! user.valid?
    assert user.errors.on(:name)
  end

  test "password is confirmed" do
    user = User.new(
      :name => "beaker",
      :password => "face!",
      :password_confirmation => "" #=> bad!
    )

    assert ! user.valid?
    assert user.errors.on(:password)
  end

  test "blank password throws an error" do
    user = User.new(
      :name => "bunson",
      :password => "",
      :password_confirmation => "" #=> bad!
    )

    assert ! user.valid?
    assert user.errors.on(:base)
    assert_match /Missing password/, user.errors["base"]
  end

  test "user gets authenticated" do
    user = users(:one)
    assert User.authenticate(user.name, 'boo')
  end

  test "bad password does not get us authenticated" do
    user = users(:one)
    assert ! User.authenticate(user.name, 'foo')
  end

  test "user not found" do
    assert ! User.authenticate('baba', 'yaga')
  end

  test "user has email address" do
    user = users(:one)
    user.email = ""
    assert ! user.valid?
    assert user.errors.on(:email)
  end

  test "user email address is unique" do
    user = User.new(
      :name => "fubar",
      :email => users(:one).email,
      :hashed_password => "funny?",
      :salt => "no, stupid"
    )
    assert ! user.valid?
    assert user.errors.on(:email)
  end

  test "user has validation for email address" do
    user = users(:one)
    assert user.respond_to?(:valid_email?)
  end

  test "user email is probably correct" do
    user = users(:one)
    user.email = "ff.art itcom"
    assert ! user.valid?
    assert user.errors.on(:email)
  end

  test "user can be an admin" do
    user = users(:one)
    user.is_admin = true
    assert user.is_admin?
  end

  test "user can not receive notifications" do
    user = users(:one)
    user.can_has_notifications = true
    assert user.can_has_notifications?
  end

  test "user has uid" do
    user = users(:one)
    user.uid = nil
    assert ! user.valid?
    assert user.errors.on(:uid)
  end

  test "user able to find uid" do
    user = users(:one)
    user.uid = 240659
    assert user.valid?
  end

  test "user gets error on uid that does not exist in nanowrimo" do
    file = File.expand_path(File.dirname(__FILE__)) + "/../fixtures/xml/user_wc_error.xml"
    FakeWeb.register_uri("#{Nanowrimo::API_URI}/wc/999999", :file => file)
    user = users(:one)
    user.uid = 999999
    assert ! user.valid?
    assert user.errors.on(:uid)
  end

  test "user can not claim uid that is already being used" do
    user = users(:one)
    user.uid = users(:renda).uid
    assert ! user.valid?
    assert user.errors.on(:uid)
  end
end
