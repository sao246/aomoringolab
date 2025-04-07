require "test_helper"

class Public::TrendsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_trends_show_url
    assert_response :success
  end
end
