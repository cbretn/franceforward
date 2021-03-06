require 'test_helper'

class DiscussionTest < ActiveSupport::TestCase

  test "saves a discussion only if all prerequisites are met" do
    discussion = Discussion.new
    assert_not discussion.save, "saved a discussion without a theme"
    discussion.theme = themes(:pollution)
    assert_not discussion.save, "saved a discussino without a user"
    discussion.user = users(:hugo)
    assert_not discussion.save, "saved a discussion without a title"
    discussion.title = "title still under redaction"
    assert_not discussion.save, "saved a discussion without a content"
    discussion.content = "Content still under redaction"
    assert discussion.save, "could not save a discussion"
    assert discussion.destroy, "could not delete discussion"
  end
end
