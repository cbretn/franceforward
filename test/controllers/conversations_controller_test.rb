require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:hugo)
  end

  test "should get index" do
    get conversations_url
    assert_response :success
  end

  test "should get create" do
    assert_difference('Conversation.count', +1) do
      post conversations_url(conversations(:vicurie)),
        params: {user1_id: users(:hugo).id, user2_id: users(:pascal).id}
    end
    assert_redirected_to conversation_messages_path(Conversation.between(users(:hugo),users(:pascal)).first)
  end

end
