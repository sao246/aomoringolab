require "test_helper"

class Admin::TrendsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_trends_index_url
    assert_response :success
  end
end
