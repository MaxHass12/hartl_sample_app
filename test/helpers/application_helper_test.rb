require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "full_title_helper" do
    BASE_TITLE = "Ruby on Rails Tutorial Sample App"
    assert_equal BASE_TITLE, full_title
    assert_equal "Help | #{BASE_TITLE}", full_title("Help")
  end
end