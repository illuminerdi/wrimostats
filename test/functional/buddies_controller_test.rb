require 'test_helper'

class BuddiesControllerTest < ActionController::TestCase
  def setup
    @request.session[:user_id] = users(:one).to_param
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buddies)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_tag :tag => "input", :attributes => {
      :name => "buddy[uid]"
    }
    assert_tag :tag => "input", :attributes => {
      :name => "buddy[user_id]"
    }
  end

  test "should create buddy" do
    assert_difference('Buddy.count') do
      post :create, :buddy => {
        :user_id => users(:renda).to_param,
        :uid => users(:reid).uid
      }
    end

    assert_redirected_to buddy_path(assigns(:buddy))
  end

  test "should show buddy" do
    get :show, :id => buddies(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => buddies(:one).to_param
    assert_response :success
    assert_tag :tag => "input", :attributes => {
      :name => "buddy[uid]"
    }
    assert_tag :tag => "input", :attributes => {
      :name => "buddy[user_id]"
    }
  end

  test "should update buddy" do
    put :update, :id => buddies(:one).to_param, :buddy => { }
    assert_redirected_to buddy_path(assigns(:buddy))
  end

  test "should destroy buddy" do
    assert_difference('Buddy.count', -1) do
      delete :destroy, :id => buddies(:one).to_param
    end

    assert_redirected_to buddies_path
  end

  # we only really care about the functionality that's going to show on the dashboard for users.
  # It will be like a widget that users will use to see their buddies, remove buddies, and add 'em.
end
