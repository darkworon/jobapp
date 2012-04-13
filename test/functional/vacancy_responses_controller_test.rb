require 'test_helper'

class VacancyResponsesControllerTest < ActionController::TestCase
  setup do
    @vacancy_response = vacancy_responses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vacancy_responses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vacancy_response" do
    assert_difference('VacancyResponse.count') do
      post :create, vacancy_response: @vacancy_response.attributes
    end

    assert_redirected_to vacancy_response_path(assigns(:vacancy_response))
  end

  test "should show vacancy_response" do
    get :show, id: @vacancy_response
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vacancy_response
    assert_response :success
  end

  test "should update vacancy_response" do
    put :update, id: @vacancy_response, vacancy_response: @vacancy_response.attributes
    assert_redirected_to vacancy_response_path(assigns(:vacancy_response))
  end

  test "should destroy vacancy_response" do
    assert_difference('VacancyResponse.count', -1) do
      delete :destroy, id: @vacancy_response
    end

    assert_redirected_to vacancy_responses_path
  end
end
