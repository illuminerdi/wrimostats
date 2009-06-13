require 'test_helper'

class WordWarsControllerTest < ActionController::TestCase
  def setup
    @request.session[:user_id] = users(:one).to_param
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:word_wars)
  end

  test "should get new" do
    get :new
    assert_response :success

    assert_tag :tag => "input", :attributes => {
      :type => "text",
      :name => "word_war[title]"
    }
    assert_tag :tag => "input", :attributes => {
      :type => "hidden",
      :name => "word_war[user_id]",
      :value => users(:one).to_param
    }
    assert_tag :tag => "textarea", :attributes => {
      :name => "word_war[description]"
    }
    assert_tag :tag => "input", :attributes => {
      :type => "checkbox",
      :name => "word_war[can_has_snaps]",
      :checked => "checked"
    }
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
    get :edit, :id => word_wars(:two).to_param
    assert_response :success

    assert_tag :tag => "input", :attributes => {
      :type => "text",
      :name => "word_war[title]"
    }
    assert_tag :tag => "input", :attributes => {
      :type => "hidden",
      :name => "word_war[user_id]",
      :value => users(:renda).to_param
    }
    assert_tag :tag => "textarea", :attributes => {
      :name => "word_war[description]"
    }
    assert_tag :tag => "input", :attributes => {
      :type => "checkbox",
      :name => "word_war[can_has_snaps]"
    }
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
