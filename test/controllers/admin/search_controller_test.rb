require "test_helper"

class Admin::SearchControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_search_index_url
    assert_response :success
  end
end
