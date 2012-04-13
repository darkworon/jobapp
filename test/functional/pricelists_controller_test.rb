require 'test_helper'

class PricelistsControllerTest < ActionController::TestCase
  setup do
    @pricelist = pricelists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pricelists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pricelist" do
    assert_difference('Pricelist.count') do
      post :create, pricelist: @pricelist.attributes
    end

    assert_redirected_to pricelist_path(assigns(:pricelist))
  end

  test "should show pricelist" do
    get :show, id: @pricelist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pricelist
    assert_response :success
  end

  test "should update pricelist" do
    put :update, id: @pricelist, pricelist: @pricelist.attributes
    assert_redirected_to pricelist_path(assigns(:pricelist))
  end

  test "should destroy pricelist" do
    assert_difference('Pricelist.count', -1) do
      delete :destroy, id: @pricelist
    end

    assert_redirected_to pricelists_path
  end
end
