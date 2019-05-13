require 'test_helper'

class ActionsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:hugo)
    @fixture_action = Action.create!(title: "Action 4", location: "Paris",
                            description: "desc", start_date: '2019-02-20',
                            end_date: '2019-02-31',
                            theme: themes(:biodiversité),
                            user: users(:hugo))
  end

  teardown do
    Rails.cache.clear
  end

  test "should get index" do
    get category_theme_actions_url(categories(:environnement), themes(:pollution))
    assert_response :success
  end

  test "should get new" do
    get new_category_theme_action_url(categories(:environnement), themes(:pollution))
    assert_response :success
  end

  # Should be fixed in a next task renaming the action model
  # test "should get create" do
  #   assert_difference('Action.count', +1) do
  #     post category_theme_actions_url(categories(:environnement), themes(:pollution)),
  #          params: {title: "Action Test", location: "Paris", start_date: "2030-01-01", end_date: "2030-12-31", description: "lorem ipsum", theme_id: themes(:pollution).id}
  #   end
  #   assert_redirected_to category_theme_action_path(Action.last.theme.category.id, Action.last.theme.id, Action.last.id)
  # end

  test "should get show" do
    get category_theme_action_url(categories(:environnement), themes(:pollution), @fixture_action)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_theme_action_url(@fixture_action.theme.category, @fixture_action.theme, @fixture_action)
    assert_response :success
  end

  # Should be fixed in a next task renaming the action model
  # test "should get update" do
  #   put category_theme_action_url(@fixture_action.theme.category, @fixture_action.theme, @fixture_action),
  #     params: {theme_id: @fixture_action.theme.id, id: @fixture_action.id, title: "Action 4 Updated"}
  #   assert_response :success
  # end

  test "should get destroy" do
    assert_difference('Action.count', -1) do
      delete category_theme_action_url(@fixture_action.theme.category, @fixture_action.theme, @fixture_action),
        params: {theme_id: @fixture_action.theme.id, id: @fixture_action.id}
    end
    assert_redirected_to category_theme_path(@fixture_action.theme.category, @fixture_action.theme)
  end

end
