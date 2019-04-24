require 'test_helper'

class DescriptionControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get category_theme_description_url(categories(:environnement), themes(:pollution), descriptions(:pollution_desc))
    assert_response :success
  end

end
