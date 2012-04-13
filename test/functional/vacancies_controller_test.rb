require 'test_helper'

class VacanciesControllerTest < ActionController::TestCase
  setup do
    @vacancy = vacancies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vacancies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vacancy" do
    assert_difference('Vacancy.count') do
      post :create, vacancy: @vacancy.attributes
    end

    assert_redirected_to vacancy_path(assigns(:vacancy))
  end

  test "should show vacancy" do
    get :show, id: @vacancy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vacancy
    assert_response :success
  end

  test "should update vacancy" do
    put :update, id: @vacancy, vacancy: @vacancy.attributes
    assert_redirected_to vacancy_path(assigns(:vacancy))
  end

  test "should destroy vacancy" do
    assert_difference('Vacancy.count', -1) do
      delete :destroy, id: @vacancy
    end

    assert_redirected_to vacancies_path
  end
end
