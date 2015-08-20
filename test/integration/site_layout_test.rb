require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup 
    @admin = users(:michael)
    @non_admin = users(:tom)
  end

  test "layout links" do 
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", users_path, count: 0
  end

  test "users link should be visible when admin signed in" do 
    sign_in_as(@admin)
    get root_path
    assert_select "a[href=?]", users_path
  end

  test "users link should not be visible when non-admin signed in" do 
    sign_in_as(@non_admin)
    get root_path
    assert_select "a[href=?]", users_path, count: 0
  end

end
