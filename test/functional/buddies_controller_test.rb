require 'test_helper'

class BuddiesControllerTest < ActionController::TestCase
  FakeWeb.allow_net_connect = false
  reid = File.expand_path(File.dirname(__FILE__)) + "/../fixtures/xml/user_245095_wc.xml"
  FakeWeb.register_uri("http://www.nanowrimo.org/wordcount_api/wc/245095", :file => reid)
  renda = File.expand_path(File.dirname(__FILE__)) + "/../fixtures/xml/user_94450_wc.xml"
  FakeWeb.register_uri("http://www.nanowrimo.org/wordcount_api/wc/94450", :file => renda)
  me = File.expand_path(File.dirname(__FILE__)) + "/../fixtures/xml/user_wc.xml"
  FakeWeb.register_uri("http://www.nanowrimo.org/wordcount_api/wc/240659", :file => me)
  bad = File.expand_path(File.dirname(__FILE__)) + "/../fixtures/xml/user_wc_error.xml"
  FakeWeb.register_uri("http://www.nanowrimo.org/wordcount_api/wc/999999", :file => bad)

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
    @request.session[:user_id] = users(:renda).to_param
    assert_difference('Buddy.count') do
      post :create, :buddy => {
        :user_id => users(:renda).to_param,
        :uid => users(:reid).uid
      }
    end

    assert_redirected_to user_path(users(:renda).to_param)
  end

  test "should handle duplicate buddy properly" do
    assert_no_difference('Buddy.count') do
      post :create, :buddy => {
        :user_id => users(:one).to_param,
        :uid => users(:renda).uid
      }
    end

    assert_redirected_to user_path(users(:one).to_param)
    assert @response.flash[:notice].include?("Nanowrimo ID given is already set up as a buddy.")
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
  context "on GET to :widget_for for first user" do
    setup do
      get :widget_for, :id => users(:one).to_param
    end

    should_assign_to :user
    should_respond_with :success

    should "give me all of the pieces" do
      assert_template :partial => '_add_buddy_form', :count => 1
      assert_template :partial => '_buddies_list', :count => 1
      assert_template :partial => '_buddy_control', :count => users(:one).buddies.size
    end

    should "have the proper columns for my list" do
      assert_tag :tag => "th", :content => /Nanowrimo Name/
      assert_tag :tag => "th", :content => /Word Count/
    end

    should "show me all of my buddies" do
      user = assigns(:user)
      user.buddies.each {|buddy|
        nano_data = Nanowrimo::User.new(buddy.uid)
        nano_data.load
        assert_tag :tag => "a",
          :content => /delete/,
          :attributes => {
            :href => /#{buddy.to_param}/
          }
        assert_match /#{nano_data.uname}/, @response.body
        assert_match /#{nano_data.user_wordcount}/, @response.body
      }
    end

    should "have all the bits to add a new buddy" do
      assert_tag :tag => "input", :attributes => {
        :name => "buddy[user_id]",
        :type => "hidden",
        :value => users(:one).to_param
      }
      assert_tag :tag => "input", :attributes => {
        :name => "buddy[uid]",
        :type => "text"
      }
    end
  end
end
