require 'test_helper'

class SubscribersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get subscribers_new_url
    assert_response :success
  end

end
