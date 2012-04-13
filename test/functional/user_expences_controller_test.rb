require 'test_helper'

class UserExpencesControllerTest < ActionController::TestCase
  setup do
    @user_expence = user_expences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_expences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_expence" do
    assert_difference('UserExpence.count') do
      post :create, user_expence: @user_expence.attributes
    end

    assert_redirected_to user_expence_path(assigns(:user_expence))
  end

  test "should show user_expence" do
    get :show, id: @user_expence
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_expence
    assert_response :success
  end

  test "should update user_expence" do
    put :update, id: @user_expence, user_expence: @user_expence.attributes
    assert_redirected_to user_expence_path(assigns(:user_expence))
  end

  test "should destroy user_expence" do
    assert_difference('UserExpence.count', -1) do
      delete :destroy, id: @user_expence
    end

    assert_redirected_to user_expences_path
  end
end
