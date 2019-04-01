require 'test_helper'

class ActionParticipationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:hugo)
    @action = Action.create!(title: "Action 4", location: "Paris",
                            description: "desc", start_date: '2019-02-20',
                            end_date: '2019-02-31',
                            theme: themes(:biodiversité),
                            user: users(:hugo))
  end

  teardown do
    Rails.cache.clear
  end

  test "should get index" do
    get category_theme_action_action_participations_url(categories(:environnement), themes(:pollution), actions(:action_1))
    assert_response :success
  end

  test "should get create" do
    sign_in users(:hugo)
    assert_difference('ActionParticipation.count', +1) do
      post category_theme_action_action_participations_url(categories(:environnement), themes(:pollution), actions(:action_1)),
           params: { action_id: actions(:action_3).id}
    end
    assert_redirected_to category_theme_action_path(ActionParticipation.last.action.theme.category.id, ActionParticipation.last.action.theme.id, ActionParticipation.last.action.id)
  end

  test "should get destroy" do
    sign_in users(:hugo)
    @theme = @action.theme
    ActionParticipation.create!(user: users(:hugo),
                                          action: @action)
    assert_difference('ActionParticipation.count', -1) do
      delete category_theme_action_action_participation_url(categories(:environnement).id, themes(:pollution).id, actions(:action_1).id, ActionParticipation.last.id),
             params: { id: ActionParticipation.last.action.id}
    end
    assert_redirected_to category_theme_action_path(@theme.category.id, @theme.id, @action)
  end

  test "should not let a user destroy another user's participation" do

  end
end
