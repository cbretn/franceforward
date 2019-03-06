require "application_system_test_case"

class CategoriesTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit "/categories"

    assert_selector "h1", text: "Catégories"
    save_and_open_screenshot
    assert_selector ".card-category", count: Category.count
  end
end
