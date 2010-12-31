require 'test_helper'

class UserLinksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_links)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_link" do
    assert_difference('UserLink.count') do
      post :create, :user_link => { }
    end

    assert_redirected_to user_link_path(assigns(:user_link))
  end

  test "should show user_link" do
    get :show, :id => user_links(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => user_links(:one).to_param
    assert_response :success
  end

  test "should update user_link" do
    put :update, :id => user_links(:one).to_param, :user_link => { }
    assert_redirected_to user_link_path(assigns(:user_link))
  end

  test "should destroy user_link" do
    assert_difference('UserLink.count', -1) do
      delete :destroy, :id => user_links(:one).to_param
    end

    assert_redirected_to user_links_path
  end
end
