require 'test_helper'

class PasswordControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get reset" do
    get :reset
    assert_response :success
  end

end
