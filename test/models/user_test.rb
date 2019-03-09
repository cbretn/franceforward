require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "saves a user only if all prerequisites are met" do
    user = User.new
    assert_not user.save, "saved a user without an email"
    user.email = 'charles.de.gaulle@gmail.com'
    assert_not user.save, "saved a user without a user"
    user.first_name = "Charles"
    assert_not user.save, "saved a user without a title"
    user.last_name = "de Gaulle"
    assert_not user.save, "saved a user without a description"
    user.location = "Colombey-les-deux-églises"
    assert_not user.save, "saved a user without a password"
    user.password = "hugohugo"
    assert user.save!, "could not save a user"
    user.remote_photo_url = "https://pbs.twimg.com/profile_images/875888968558161920/qNQE606I_400x400.jpg"
    assert_not_nil user.photo
    assert user.destroy, "could not delete user"
  end

  test "new users should not be admin" do
    user = User.new(email: 'charles.de.gaulle@gmail.com',
                    first_name: "Charles",
                    last_name: "de Gaulle",
                    location: "Colombey-les-deux-églises",
                    password: "hugohugo")
    user.save!
    assert_not user.admin
  end

  test "user's discussions are destroyed when user is" do
    user = User.new(category: Category.find_by(name: "Environnement"), name: "Elevage Industriel",
                        content: "Content still under redaction", photo: "image/upload/v1551362849/g1fz1yrrwlampiqiofkp.jpg")
    user.save!
    discussion_1 = Discussion.new(user: users(:hugo), content: "content still under redaction", title: "discussion 1")
    discussion_1.user = user
    discussion_1.save!
    discussion_2 = Discussion.new(user: User.find_by(email: "victor-hugo@hotmail.fr"), content: "content still under redaction", title: "discussion 2")
    discussion_2.user = user
    discussion_2.save!
    user.destroy!
    assert_not Discussion.exists?(discussion_1.id) || Discussion.exists?(discussion_2.id), "message was not deleted with parent user"
  end

  test "user's actions are destroyed when user is" do
    user = User.new(category: Category.find_by(name: "Environnement"), name: "Elevage Industriel",
                        content: "Content still under redaction", photo: "image/upload/v1551362849/g1fz1yrrwlampiqiofkp.jpg")
    user.save!
    action_1 = Action.new(user: User.find_by(email: "victor-hugo@hotmail.fr"), description: "content still under redaction", title: "action 1")
    action_1.user = user
    action_1.save!
    action_2 = Action.new(user: User.find_by(email: "victor-hugo@hotmail.fr"), description: "content still under redaction", title: "action 2")
    action_2.user = user
    action_2.save!
    user.destroy!
    assert_not Action.exists?(action_1.id) || Action.exists?(action_2.id), "action was not deleted with parent user"
  end

  test "user's participations are destroyed when user is" do
    user = User.new(category: Category.find_by(name: "Environnement"), name: "Elevage Industriel",
                        content: "Content still under redaction", photo: "image/upload/v1551362849/g1fz1yrrwlampiqiofkp.jpg")
    user.save!
    discussion_1 = Discussion.new(user: User.find_by(email: "victor-hugo@hotmail.fr"), content: "content still under redaction", title: "discussion 1")
    discussion_1.user = user
    discussion_1.save!
    discussion_2 = Discussion.new(user: User.find_by(email: "victor-hugo@hotmail.fr"), content: "content still under redaction", title: "discussion 2")
    discussion_2.user = user
    discussion_2.save!
    user.destroy!
    assert_not Discussion.exists?(discussion_1.id) || Discussion.exists?(discussion_2.id), "message was not deleted with parent user"
  end

  test "user's conversations are destroyed when user is" do
    user = User.new(category: Category.find_by(name: "Environnement"), name: "Elevage Industriel",
                        content: "Content still under redaction", photo: "image/upload/v1551362849/g1fz1yrrwlampiqiofkp.jpg")
    user.save!
    action_1 = Action.new(user: User.find_by(email: "victor-hugo@hotmail.fr"), description: "content still under redaction", title: "action 1")
    action_1.user = user
    action_1.save!
    action_2 = Action.new(user: User.find_by(email: "victor-hugo@hotmail.fr"), description: "content still under redaction", title: "action 2")
    action_2.user = user
    action_2.save!
    user.destroy!
    assert_not Action.exists?(action_1.id) || Action.exists?(action_2.id), "action was not deleted with parent user"
  end
end
