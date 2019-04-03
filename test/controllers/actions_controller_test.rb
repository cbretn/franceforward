require 'test_helper'

class ActionsControllerTest < ActionDispatch::IntegrationTest
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
    get category_theme_actions_url(categories(:environnement), themes(:pollution))
    assert_response :success
  end

  test "should get new" do
    get new_category_theme_action_url(categories(:environnement), themes(:pollution))
    assert_response :success
  end

  test "should get create" do
    assert_difference('Action.count', +1) do
      post category_theme_actions_url(categories(:environnement), themes(:pollution)),
           params: { title: "Action Test", location: "Paris", start_date: "2030-01-01", end_date: "2030-12-31", description: "lorem ipsum", theme_id: themes(:pollution).id}
    end
    assert_redirected_to category_theme_action_path(Action.last.theme.category.id, Action.last.theme.id, Action.last.id)
  end

  test "should get show" do
    get category_theme_action_url(categories(:environnement), themes(:pollution), @action)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_theme_action_url(@action) # (categories(:environnement), themes(:pollution), actions(:action_1))
    assert_response :success
  end

  test "should get update" do
    put category_theme_action_url(@action)
    assert_response :success
  end

  test "should get destroy" do
    assert_difference('Action.count', -1) do
      delete category_theme_action_url(@action)
    end
    assert_response :success
  end
end

# category_theme_actions GET    /categories/:category_id/themes/:theme_id/actions(.:format)                                      actions#index
#                                             POST   /categories/:category_id/themes/:theme_id/actions(.:format)                                      actions#create
#                   new_category_theme_action GET    /categories/:category_id/themes/:theme_id/actions/new(.:format)                                  actions#new
#                  edit_category_theme_action GET    /categories/:category_id/themes/:theme_id/actions/:id/edit(.:format)                             actions#edit
#                       category_theme_action GET    /categories/:category_id/themes/:theme_id/actions/:id(.:format)                                  actions#show
#                                             PATCH  /categories/:category_id/themes/:theme_id/actions/:id(.:format)                                  actions#update
#                                             PUT    /categories/:category_id/themes/:theme_id/actions/:id(.:format)                                  actions#update
#                                             DELETE /categories/:category_id/themes/:theme_id/actions/:id(.:format)                                  actions#destroy
