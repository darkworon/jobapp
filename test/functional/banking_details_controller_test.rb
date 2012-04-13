require 'test_helper'

class BankingDetailsControllerTest < ActionController::TestCase
  setup do
    @banking_detail = banking_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:banking_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create banking_detail" do
    assert_difference('BankingDetail.count') do
      post :create, banking_detail: @banking_detail.attributes
    end

    assert_redirected_to banking_detail_path(assigns(:banking_detail))
  end

  test "should show banking_detail" do
    get :show, id: @banking_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @banking_detail
    assert_response :success
  end

  test "should update banking_detail" do
    put :update, id: @banking_detail, banking_detail: @banking_detail.attributes
    assert_redirected_to banking_detail_path(assigns(:banking_detail))
  end

  test "should destroy banking_detail" do
    assert_difference('BankingDetail.count', -1) do
      delete :destroy, id: @banking_detail
    end

    assert_redirected_to banking_details_path
  end
end
