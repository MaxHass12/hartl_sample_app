require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "Login with invalid information" do
    get login_path
    assert_select "title", full_title("Log In")
    post login_path, params: {
      session: {
        email: "",
        password: ""
      }
    }
    assert_response :unprocessable_entity
    assert_select "title", full_title("Log In")
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    post login_path, params: { session: {
      email: @user.email,
      password: "password"
    }}
    assert_redirected_to @user
    follow_redirect!
    assert is_logged_in?
    assert_select "title", full_title(@user.name)
    assert_select "a[href=?]", login_path, count: 0
    assert_select "button", "Logout"
    assert_select "a[href=?]", user_path(@user)
  end

  test "logout" do
    post login_path, params: { session: {
      email: @user.email,
      password: "password"
    }} 
    follow_redirect!
    assert is_logged_in?
    assert_select "button", "Logout"
    delete logout_path
    assert_response :see_other
    assert_redirected_to root_url
    follow_redirect!
    assert_not is_logged_in?
    assert_not flash.empty?
    # simulate a user clicking logout in second window
    delete logout_path
    follow_redirect!
    assert_not is_logged_in?
  end

  test "failed login in valid email / invalid password" do
    get login_path
    assert_select "title", full_title("Log In")

    post login_path, params: {session: {
      email: @user.email,
      password: "wrong_password"
    }}
    assert_response :unprocessable_entity
    assert_not is_logged_in?
    assert_select "title", full_title("Log In")
    assert_not flash.empty?

    get root_path
    assert flash.empty?
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not cookies[:remember_token].blank?
  end

  test "login without remembering" do
    # log in to set the cookies
    log_in_as(@user, remember_me: '1')
    # log in again and verify that the cookie is deleted
    log_in_as(@user, remember_me: '0')
    assert cookies[:remember_token].blank?
  end
end
