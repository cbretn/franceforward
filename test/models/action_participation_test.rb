require 'test_helper'

class ActionParticipationTest < ActiveSupport::TestCase

  test "saves an action participation only if all prerequisites are met" do
    participation = ActionParticipation.new
    assert_not participation.save, "saved a participation without an action"
    participation.action = Action.find_by(title: 'Action 2')
    assert_not participation.save, "saved a participation without a user"
    participation.user = User.find_by(email: 'victor-hugo@hotmail.fr')
    assert participation.save, "could not save a participation"
    assert participation.destroy, "could not delete participation"
  end

  test "does not let a user participate twice to the same action" do
    hugo_part_1 = ActionParticipation.new(user: User.find_by(email: 'victor-hugo@hotmail.fr'),
                                          action: Action.find_by(title: 'Action 2'))
    assert hugo_part_1.save, "could not save first action participation"
    hugo_part_2 = ActionParticipation.new(user: User.find_by(email: 'victor-hugo@hotmail.fr'),
                                          action: Action.find_by(title: 'Action 2'))
    assert_not hugo_part_2.save, "could save second action participation"
    hugo_part_1.destroy
    hugo_part_2.destroy
  end
end
