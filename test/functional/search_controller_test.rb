require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test "should get resume" do
    get :resume
    assert_response :success
  end

  test "should get vacancy" do
    get :vacancy
    assert_response :success
  end

end
