ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  include Warden::Test::Helpers
  Warden.test_mode!
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    'chromeOptions' => { args: %w(headless disable-gpu) + [ 'window-size=1280,800' ] })
  Capybara::Selenium::Driver.new app, browser: :chrome, desired_capabilities: capabilities
end
Capybara.save_path = Rails.root.join('tmp/capybara')
Capybara.javascript_driver = :headless_chrome

module SignInHelper
  def sign_in_as(user)
    get new_user_session_url
    post user_session_url(email: user.email,
                          password: user.password,
                          remember_me: user.remember_me)
  end

  def sign_in_as2(user)
    post sign_in_url(email: user.email, password: user.password)
  end
end

class ActionDispatch::IntegrationTest
  include SignInHelper
end
