require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "saves a category only if all prerequisites are met" do
    category = Category.new
    assert_not category.save, "saved a category without a name"
    category.name = "Exploration interplanétaire"
    assert_not category.save, "saved a category without a picture"
    category.remote_photo_url = "https://res.cloudinary.com/cbretn/image/upload/v1551324911/franceforward/categories/environnement.jpg"
    assert category.save, "could not save a category"
    assert category.destroy, "could not delete category"
  end
end
