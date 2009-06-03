require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @request.session[:user_id] = users(:one).id
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
  end
end