require 'test_helper'

class OhSnapsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:oh_snaps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create oh_snap" do
    assert_difference('OhSnap.count') do
      post :create, :oh_snap => { }
    end

    assert_redirected_to oh_snap_path(assigns(:oh_snap))
  end

  test "should show oh_snap" do
    get :show, :id => oh_snaps(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => oh_snaps(:one).to_param
    assert_response :success
  end

  test "should update oh_snap" do
    put :update, :id => oh_snaps(:one).to_param, :oh_snap => { }
    assert_redirected_to oh_snap_path(assigns(:oh_snap))
  end

  test "should destroy oh_snap" do
    assert_difference('OhSnap.count', -1) do
      delete :destroy, :id => oh_snaps(:one).to_param
    end

    assert_redirected_to oh_snaps_path
  end
end
