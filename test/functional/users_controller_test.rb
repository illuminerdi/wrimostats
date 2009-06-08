require 'test_helper'
require 'fakeweb'

class UsersControllerTest < ActionController::TestCase

  def setup
    @request.session[:user_id] = users(:one).id
    FakeWeb.allow_net_connect=false
    file = File.expand_path(File.dirname(__FILE__)) + "/../fixtures/xml/user_wc.xml"
    FakeWeb.register_uri("#{Nanowrimo::API_URI}/wc/240659", :file => file)
    FakeWeb.register_uri("#{Nanowrimo::API_URI}/wc/123456", :file => file)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_tag :tag => 'input', :attributes => {
      :name => 'user[name]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'user[password]'
    }
    assert_tag :tag => "input", :attributes => {
      :name => "user[email]"
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'user[password_confirmation]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'user[uid]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'user[can_has_notifications]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'user[is_admin]'
    }
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => {
        :name => 'hollowedout',
        :email => 'control@hollowedout.com',
        :password => 'fubar',
        :password_confirmation => 'fubar',
        :uid => 240659
      }
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, :id => users(:one).to_param
    assert_response :success

  end

  test "should get edit" do
    get :edit, :id => users(:one).to_param
    assert_response :success
    assert_tag :tag => 'input', :attributes => {
      :name => 'user[name]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'user[password]'
    }
    assert_tag :tag => "input", :attributes => {
      :name => "user[email]"
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'user[password_confirmation]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'user[uid]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'user[can_has_notifications]'
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'user[is_admin]'
    }
  end

  test "should update user" do
    put :update, :id => users(:one).to_param, :user => {
      :password => 'solomongrundy',
      :password_confirmation => 'solomongrundy'
    }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => users(:one).to_param
    end

    assert_redirected_to users_path
    assert_equal @response.flash[:notice], "User #{users(:one).name} deleted"
  end

  test "should not destroy the last user" do
    users = User.find(:all)
    assert_raise(RuntimeError) do
      loop do
        users.first.destroy
        users.shift
      end
    end

   assert_equal 1, users.length
  end

  test "should give new users a sign up form" do
    get :signup
    assert_response :success
    assert_tag :tag => "input", :attributes => {
      :name => "user[name]"
    }
    assert_tag :tag => "input", :attributes => {
      :name => "user[email]"
    }
    assert_tag :tag => "input", :attributes => {
      :name => "user[password]"
    }
    assert_tag :tag => "input", :attributes => {
      :name => "user[password_confirmation]"
    }
    assert_tag :tag => "input", :attributes => {
      :name => "user[uid]"
    }
    assert_tag :tag => 'input', :attributes => {
      :name => 'user[can_has_notifications]'
    }
    assert_tag :tag => 'a', :attributes => {
      :href => '/notifications.html'
    }
    assert_tag :tag => 'a', :attributes => {
      :href => '/nanowrimo_user_id.html'
    }
  end

  test "should show someone a login page" do
    get :login
    assert_response :success
    assert_tag :tag => "input", :attributes => {
      :name => "name"
    }
    assert_tag :tag => "input", :attributes => {
      :name => "password", :type => "password"
    }
    assert_tag :tag => "a", :attributes => {
      :href => "/users/signup"
    }
    assert_match /Need an account\? Create one!/, @response.body
  end

  test "should give me a login form on the same page as the signup duh" do
    get :signup
    assert_template :partial => '_login_form', :count => 1
  end

  test "user is able to successfully log in" do
    user = users(:one)
    @request.session[:user_id] = nil
    post :login, :name => user.name, :password => 'boo'

    assert_redirected_to user_path(user.id)
    assert @response.session[:user_id]
  end

  test "user is unable to log in" do
    user = users(:one)
    @request.session[:user_id] = nil
    post :login, :name => user.name, :password => 'foo'

    assert_response :success
    assert ! @response.session[:user_id]
    assert_match /Invalid user\/password combination/, @response.body
  end
end