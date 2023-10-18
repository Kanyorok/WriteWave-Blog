require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get WriteWave-Blog" do
    get pages_WriteWave-Blog_url
    assert_response :success
  end
end
