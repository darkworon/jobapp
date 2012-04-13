require 'test_helper'

class PaymentProvidersControllerTest < ActionController::TestCase
  setup do
    @payment_provider = payment_providers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payment_providers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment_provider" do
    assert_difference('PaymentProvider.count') do
      post :create, payment_provider: @payment_provider.attributes
    end

    assert_redirected_to payment_provider_path(assigns(:payment_provider))
  end

  test "should show payment_provider" do
    get :show, id: @payment_provider
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payment_provider
    assert_response :success
  end

  test "should update payment_provider" do
    put :update, id: @payment_provider, payment_provider: @payment_provider.attributes
    assert_redirected_to payment_provider_path(assigns(:payment_provider))
  end

  test "should destroy payment_provider" do
    assert_difference('PaymentProvider.count', -1) do
      delete :destroy, id: @payment_provider
    end

    assert_redirected_to payment_providers_path
  end
end
