require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end

  test "email should be of valid format" do
    @user.email = "foo"
    assert_not @user.valid?

    @user.email = "foo@bar.com"
    assert @user.valid?
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email.upcase!
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lowercase" do
    mixed_case_email = "Foo@ExAmPlE.com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present(non blank)" do
    @user.password = @user.password_confirmation = "         "
    assert_not @user.valid?
  end

  test "password should be at least 6 chars" do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end
end
