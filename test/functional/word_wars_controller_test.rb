require 'test_helper'

class WordWarsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:word_wars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create word_war" do
    assert_difference('WordWar.count') do
      post :create, :word_war => {
        :user_id => users(:one).to_param,
        :title => "Test Word War"
      }
    end

    assert_redirected_to word_war_path(assigns(:word_war))
  end

  test "should show word_war" do
    get :show, :id => word_wars(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => word_wars(:one).to_param
    assert_response :success
  end

  test "should update word_war" do
    put :update, :id => word_wars(:one).to_param, :word_war => { }
    assert_redirected_to word_war_path(assigns(:word_war))
  end

  test "should destroy word_war" do
    assert_difference('WordWar.count', -1) do
      delete :destroy, :id => word_wars(:one).to_param
    end

    assert_redirected_to word_wars_path
  end
end
