require 'test_helper'

class ActionParticipationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get action_participations_index_url
    assert_response :success
  end

  test "should get new" do
    get action_participations_new_url
    assert_response :success
  end

  test "should get create" do
    get action_participations_create_url
    assert_response :success
  end

  test "should get show" do
    get action_participations_show_url
    assert_response :success
  end

  test "should get edit" do
    get action_participations_edit_url
    assert_response :success
  end

  test "should get update" do
    get action_participations_update_url
    assert_response :success
  end

  test "should get destroy" do
    get action_participations_destroy_url
    assert_response :success
  end

end
