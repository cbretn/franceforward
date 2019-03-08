require 'test_helper'

class DescriptionTest < ActiveSupport::TestCase

  test "saves a description only if all prerequisites are met" do
    description = Description.new
    assert_not description.save, "saved a description without a theme"
    description.theme = Theme.find_by(name: "Pollution")
    assert_not description.save, "saved a description without a content"
    description.content = "Content still under redaction"
    assert description.save, "could not save a description"
    assert description.destroy, "could not delete description"
  end


end
