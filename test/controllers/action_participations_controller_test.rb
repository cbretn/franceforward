require 'test_helper'

class ActionParticipationsControllerTest < ActionDispatch::IntegrationTest

  setup do
    sign_in_as users(:hugo)
    assert_response :success
  end

  teardown do
    Rails.cache.clear
  end

  test "should get index" do
    get :index
    # get category_theme_action_action_participations_path(categories(:environnement), themes(:pollution), actions(:action_1))
    assert_response :success
  end

  test "should get create" do
    sign_in_as users(:hugo)
    assert_response :success
    assert_difference('ActionParticipation.count') do
      # post category_theme_action_action_participations_url(categories(:environnement).id, themes(:pollution).id, actions(:action_1).id)
      post :create, action_participation: { user: users(:hugo),
                                            action: actions(:action_2) }
      #, params: { action_id: actions(:action_1).id, theme_id: themes(:pollution).id, category_id: categories(:environnement).id}
      # (categories(:environnement).id, themes(:pollution).id, actions(:action_1).id)
      assert_response :success
    end
    assert_redirected_to category_theme_action_action_participations_path(ActionParticipation.last.action)
  end

  test "should get destroy" do
    # sign_in_as users(:hugo)
    assert_difference('ActionParticipation.count', -1) do
      delete :destroy, params: { id: ActionParticipation.last.id }
      # delete category_theme_action_action_participation_url(categories(:environnement).id, themes(:pollution).id, actions(:action_1).id, ActionParticipation.last.id)
    end
    assert_redirected_to category_theme_action_action_participations_path(ActionParticipation.last.action)
  end

end
