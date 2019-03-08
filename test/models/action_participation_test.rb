require 'test_helper'

class ActionParticipationTest < ActiveSupport::TestCase

  test "saves an action participation only if all prerequisites are met" do
    action = Action.new
    assert_not action.save, "saved an action without a theme"
    action.theme = Theme.find_by(name: 'Pollution')
    assert_not action.save, "saved an action without a user"
    action.user = User.find_by(email: 'victor-hugo@hotmail.fr')
    assert_not action.save, "saved an action without a title"
    action.title = "Club de lecture"
    assert_not action.save, "saved an action without a description"
    action.description = "Venez écouter Victor Hugo lire les classiques de la littérature"
    assert action.save, "could not save an action"
    assert action.destroy, "could not delete action"
  end

end
