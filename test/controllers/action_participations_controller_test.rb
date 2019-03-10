require 'test_helper'

class ActionParticipationsControllerTest < ActionDispatch::IntegrationTest

  setup do
    # @participation = action_participations(:one)
  end

  teardown do
    Rails.cache.clear
  end

  test "should get index" do
    get category_theme_action_action_participations_path(categories(:environnement), themes(:pollution), actions(:action_1))
    assert_response :success
  end

  test "should get create" do
    sign_in_as users(:hugo)
    assert_response :success
    assert_difference('ActionParticipation.count') do
      post category_theme_action_action_participations_path, params: { action: actions(:action_1), theme: themes(:pollution), category: categories(:environnement)}, method: 'post'
      # (categories(:environnement).id, themes(:pollution).id, actions(:action_1).id)
      assert_response :success
    end
    assert_redirected_to category_theme_action_action_participations_path(ActionParticipation.last.action)
  end

  test "should get destroy" do
    sign_in_as users(:hugo)
    assert_difference('ActionParticipation.count', -1) do
      delete category_theme_action_action_participation_path(ActionParticipation.last)
    end
    assert_redirected_to category_theme_action_action_participations_path(ActionParticipation.last.action)
  end

end
