require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  test "saves a conversation only if all prerequisites are met" do
    conversation = Conversation.new
    assert_not conversation.save, "saved a conversation without a first user"
    conversation.user1 = User.find_by(email: "victor-hugo@hotmail.fr")
    assert_not conversation.save, "saved a conversation without a second user"
    conversation.user2 = User.new(first_name: "chateau", last_name: "briand", email: "chateaubriand@hotmail.fr", location: "Bretagne")
    assert conversation.save, "could not save a conversation"
    assert conversation.destroy, "could not delete conversation"
  end

  test "does not allow for duplicate conversations" do
    second_conversation = Conversation.new
    second_conversation.user1, second_conversation.user2 = users(:hugo, :curie)
    # second_conversation.user1 = User.find_by(email: "victor-hugo@hotmail.fr")
    # second_conversation.user2 = User.find_by(email: "marie-curie@hotmail.fr")
    assert_not second_conversation.save, "could save a conversation that already existed"
  end

  test "conversation's messages are destroyed when conversation is" do
    conversation = Conversation.new
    conversation.user1 = User.find_by(email: "victor-hugo@hotmail.fr")
    conversation.user2 = User.new(first_name: "chateau", last_name: "briand", email: "chateaubriand@hotmail.fr", location: "Bretagne")
    conversation.save!
    message_1 = Message.new(user: User.find_by(email: "victor-hugo@hotmail.fr"), body: "Hello")
    message_1.conversation = conversation
    message_1.save
    message_2 = Message.new(user: User.find_by(email: "victor-hugo@hotmail.fr"), body: "Ça va ?")
    message_2.conversation = conversation
    message_2.save
    conversation.destroy
    assert_not Message.exists?(message_1.id) || Message.exists?(message_2.id), "message was not deleted with parent conversation"
  end
end
