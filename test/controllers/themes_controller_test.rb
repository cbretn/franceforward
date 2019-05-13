require 'test_helper'

class ThemesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get category_themes_path(categories(:environnement))
    assert_response :success
  end

  test "should get show" do
    get category_theme_path(categories(:environnement), themes(:pollution))
    assert_response :success
  end

  test "should get all" do
    get themes_url
    assert_response :success
  end
end
