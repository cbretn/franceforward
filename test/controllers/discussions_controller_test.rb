require 'test_helper'
# require 'pry-byebug'

class DiscussionsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:hugo)
    @fixture_discussion = Discussion.create!(title: "Discussion 3",
                            content: "Je pense que ça",
                            theme: themes(:biodiversité),
                            user: users(:hugo))
  end

  teardown do
    Rails.cache.clear
  end

  test "should get index" do
    get category_theme_discussions_url(categories(:environnement).id, themes(:pollution).id)
    assert_response :success
  end

  test "should get new" do
    get new_category_theme_discussion_url(categories(:environnement), themes(:pollution))
    assert_response :success
  end

  test "should get create" do
    assert_difference('Discussion.count', +1) do
      post category_theme_discussions_url(categories(:environnement), themes(:pollution)),
           params: {discussion: {title: "Action Test", content: "lorem ipsum"}, theme_id: themes(:pollution).id}
    end
    assert_redirected_to category_theme_discussion_path(Discussion.last.theme.category.id, Discussion.last.theme.id, Discussion.last.id)
  end

  test "should get show" do
    get category_theme_discussion_url(categories(:environnement), themes(:pollution), @fixture_discussion)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_theme_discussion_url(@fixture_discussion.theme.category, @fixture_discussion.theme, @fixture_discussion)
    assert_response :success
  end

  test "should get update" do
    put category_theme_discussion_url(@fixture_discussion.theme.category, @fixture_discussion.theme, @fixture_discussion),
      params: {discussion: {theme_id: @fixture_discussion.theme.id, id: @fixture_discussion.id, title: "discussion 4 Updated"}}
    assert_redirected_to category_theme_discussion_path(@fixture_discussion)
  end

  test "should get destroy" do
    assert_difference('Discussion.count', -1) do
      delete category_theme_discussion_url(@fixture_discussion.theme.category, @fixture_discussion.theme, @fixture_discussion),
        params: {theme_id: @fixture_discussion.theme.id, id: @fixture_discussion.id}
    end
    assert_redirected_to category_theme_path(@fixture_discussion.theme.category, @fixture_discussion.theme)
  end


end
