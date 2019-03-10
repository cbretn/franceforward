require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  test "saves a message only if all prerequisites are met" do
    message = Message.new
    assert_not message.save, "saved a message without a user"
    message.user = users(:hugo)
    assert_not message.save, "saved a message without a conversation"
    message.conversation = Conversation.find_by(user1: User.find_by(email: 'victor-hugo@hotmail.fr'))
    assert_not message.save, "saved a message without a body"
    message.body = "Hey, what's up?"
    assert message.save, "could not save a message"
    assert message.destroy, "could not delete message"
  end

  test "message is unread by default" do
    message = Message.new(user: users(:hugo),
                          conversation: conversations(:vicurie),
                          body: "Hey, what's up?")
    message.save!
    assert_equal message.read, false
    message.destroy!
  end

  test "message_time" do
    message = Message.new(user: users(:hugo),
                          conversation: conversations(:vicurie),
                          body: "Hey, what's up?")
    message.save!
    assert_equal message.message_time, message.created_at.strftime("%m/%d/%y at %l:%M %p")
    message.destroy!
  end
end
