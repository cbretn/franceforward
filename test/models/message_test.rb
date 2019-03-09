require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  test "saves a message only if all prerequisites are met" do
    message = Message.new
    assert_not message.save, "saved a message without a user"
    message.user = User.find_by(email: "victor-hugo@hotmail.fr")
    assert_not message.save, "saved a message without a conversation"
    message.conversation = Conversation.find_by(user1: hugo).first
    assert_not message.save, "saved a message without a body"
    message.body = "Hey, what's up?"
    assert message.save, "could not save a message"
    assert message.destroy, "could not delete message"
  end

  test "message_time" do
    message = Message.new
    assert_equal (message.message_time, message.created_at.strftime("%m/%d/%y at %l:%M %p"))
  end
end
