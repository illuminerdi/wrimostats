require 'test_helper'

class UserTest < ActiveSupport::TestCase
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
  
  test "user email is probably correct" do
    user = users(:one)
    user.email = "ff.art@itcom"
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
end
