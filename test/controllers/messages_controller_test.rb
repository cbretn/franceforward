require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:hugo)
  end

  teardown do
    Rails.cache.clear
  end

  test "should get index" do
    get conversation_messages_path(conversations(:vicurie))
    assert_response :success
  end

  test "should get create" do
    post conversation_messages_path(conversations(:vicurie)),
      params: {message: {body: "Hello, Marie, ça roule?"}}
    assert_response :success
  end

end
