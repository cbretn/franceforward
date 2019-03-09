require 'test_helper'

class ThemeTest < ActiveSupport::TestCase

  test "saves a theme only if all prerequisites are met" do
    theme = Theme.new
    assert_not theme.save, "saved a theme without a category"
    theme.category = Category.find_by(name: "Environnement")
    assert_not theme.save, "saved a theme without a name"
    theme.name = "Élevage industriel"
    assert_not theme.save, "saved a theme without a picture"
    theme.remote_photo_url = "https://res.cloudinary.com/cbretn/image/upload/v1551329103/franceforward/themes/dechets.jpg"
    assert_not theme.save, "saved a theme without a content"
    theme.content = "Content still under redaction"
    assert theme.save, "could not save a theme"
    assert theme.destroy, "could not delete theme"
  end

  test "does not let two themes have the same name" do
    theme_1 = Theme.new(category: Category.find_by(name: "Environnement"), name: "Elevage Industriel",
                        content: "Content still under redaction", photo: "image/upload/v1551362849/g1fz1yrrwlampiqiofkp.jpg")
    assert theme_1.save, "could not save first theme"
    theme_2 = Theme.new(category: Category.find_by(name: "Environnement"), name: "Elevage Industriel",
                        content: "Content still under redaction", photo: "image/upload/v1551362849/g1fz1yrrwlampiqiofkp.jpg")
    assert_not theme_2.save, "could save second theme"
    theme_1.destroy
    theme_2.destroy
  end


  test "theme's description is destroyed when theme is" do
    theme = Theme.new(category: Category.find_by(name: "Environnement"), name: "Elevage Industriel",
                        content: "Content still under redaction", photo: "image/upload/v1551362849/g1fz1yrrwlampiqiofkp.jpg")
    theme.save!
    description = Description.new(content: "content still under redaction")
    description.theme = theme
    description.save!
    theme.destroy!
    assert_not Description.exists?(description.id), "description was not deleted with parent theme"
  end

  test "theme's discussions are destroyed when theme is" do
    theme = Theme.new(category: Category.find_by(name: "Environnement"), name: "Elevage Industriel",
                        content: "Content still under redaction", photo: "image/upload/v1551362849/g1fz1yrrwlampiqiofkp.jpg")
    theme.save!
    discussion_1 = Discussion.new(user: User.find_by(email: "victor-hugo@hotmail.fr"), content: "content still under redaction", title: "discussion 1")
    discussion_1.theme = theme
    discussion_1.save!
    discussion_2 = Discussion.new(user: User.find_by(email: "victor-hugo@hotmail.fr"), content: "content still under redaction", title: "discussion 2")
    discussion_2.theme = theme
    discussion_2.save!
    theme.destroy!
    assert_not Discussion.exists?(discussion_1.id) || Discussion.exists?(discussion_2.id), "message was not deleted with parent theme"
  end

  test "theme's actions are destroyed when theme is" do
    theme = Theme.new(category: Category.find_by(name: "Environnement"), name: "Elevage Industriel",
                        content: "Content still under redaction", photo: "image/upload/v1551362849/g1fz1yrrwlampiqiofkp.jpg")
    theme.save!
    action_1 = Action.new(user: User.find_by(email: "victor-hugo@hotmail.fr"), description: "content still under redaction", title: "action 1")
    action_1.theme = theme
    action_1.save!
    action_2 = Action.new(user: User.find_by(email: "victor-hugo@hotmail.fr"), description: "content still under redaction", title: "action 2")
    action_2.theme = theme
    action_2.save!
    theme.destroy!
    assert_not Action.exists?(action_1.id) || Action.exists?(action_2.id), "action was not deleted with parent theme"
  end
end
