require "test_helper"

class UserFlowTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
  end

  test "should create a user" do
    post user_registration_path, params: { 
      user: {
        email: "test0000@example.com",
        password: "password123",
        password_confirmation: "password123"
      } 
    }
    follow_redirect!
    assert_select "p", "No task for today!"
  end

  test "should login a user" do
    post user_session_path, params: { 
      user: {
        email: @user.email,
        password: "password"
      }
    }
    follow_redirect!
    assert_select "h1", "Category List"
  end
end
