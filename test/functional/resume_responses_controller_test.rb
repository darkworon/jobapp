require 'test_helper'

class ResumeResponsesControllerTest < ActionController::TestCase
  setup do
    @resume_response = resume_responses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resume_responses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resume_response" do
    assert_difference('ResumeResponse.count') do
      post :create, resume_response: @resume_response.attributes
    end

    assert_redirected_to resume_response_path(assigns(:resume_response))
  end

  test "should show resume_response" do
    get :show, id: @resume_response
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @resume_response
    assert_response :success
  end

  test "should update resume_response" do
    put :update, id: @resume_response, resume_response: @resume_response.attributes
    assert_redirected_to resume_response_path(assigns(:resume_response))
  end

  test "should destroy resume_response" do
    assert_difference('ResumeResponse.count', -1) do
      delete :destroy, id: @resume_response
    end

    assert_redirected_to resume_responses_path
  end
end
