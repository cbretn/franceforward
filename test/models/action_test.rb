require 'test_helper'

class ActionTest < ActiveSupport::TestCase

  test "saves an action only if all prerequisites are met" do
    action = Action.new
    assert_not action.save, "saved an action without a theme"
    action.theme = themes(:pollution)
    assert_not action.save, "saved an action without a user"
    action.user = users(:hugo)
    assert_not action.save, "saved an action without a title"
    action.title = "Club de lecture"
    assert_not action.save, "saved an action without a description"
    action.description = "Venez écouter Victor Hugo lire les classiques de la littérature"
    assert action.save, "could not save an action"
    assert action.destroy, "could not delete action"
  end

end
