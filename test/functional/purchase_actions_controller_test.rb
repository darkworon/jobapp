require 'test_helper'

class PurchaseActionsControllerTest < ActionController::TestCase
  setup do
    @purchase_action = purchase_actions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchase_actions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase_action" do
    assert_difference('PurchaseAction.count') do
      post :create, purchase_action: @purchase_action.attributes
    end

    assert_redirected_to purchase_action_path(assigns(:purchase_action))
  end

  test "should show purchase_action" do
    get :show, id: @purchase_action
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @purchase_action
    assert_response :success
  end

  test "should update purchase_action" do
    put :update, id: @purchase_action, purchase_action: @purchase_action.attributes
    assert_redirected_to purchase_action_path(assigns(:purchase_action))
  end

  test "should destroy purchase_action" do
    assert_difference('PurchaseAction.count', -1) do
      delete :destroy, id: @purchase_action
    end

    assert_redirected_to purchase_actions_path
  end
end
