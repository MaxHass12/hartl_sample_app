require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: {
        name: "",
        email: "user@invalid",
        password: "foo",
        password_confirmation: "bar"
      }}
      assert_response :unprocessable_entity
      assert_select "title", "Sign Up | Ruby on Rails Tutorial Sample App"
    end
  end

  test "valid signup information" do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {
        name: "Example User",
        email: "user@example.com",
        password: "password",
        password_confirmation: "password"
      }}
      follow_redirect!
      assert_select "title", full_title("Example User")
      assert_not flash.empty?
    end
  end
end
