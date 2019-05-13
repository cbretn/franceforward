require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:hugo)
  end

  teardown do
    Rails.cache.clear
  end

  test "should get index" do
    get conversation_messages_path()
    assert_response :success
  end

  test "should get create" do
    get messages_create_url
    assert_response :success
  end

end
