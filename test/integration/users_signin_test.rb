require 'test_helper'

class UsersSigninTest < ActionDispatch::IntegrationTest

  def setup 
    @user = users(:michael)
  end

  test "sign in with invalid information" do 
    get signin_path
    assert_template 'sessions/new'
    post signin_path session: { email: "", password: "" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "sign in with valid information followed by sign out" do 
    get signin_path
    post signin_path session: { email: @user.email, password: 'password1234' }
    assert is_signed_in?
    assert_redirected_to @user 
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", signin_path, count: 0
    assert_select "a[href=?]", signout_path
    delete signout_path
    assert_not is_signed_in?
    assert_redirected_to root_url
    # Simulate a user clicking sign out in a second window
    delete signout_path 
    follow_redirect!
    assert_select "a[href=?]", signin_path
    assert_select "a[href=?]", signout_path, count: 0
  end

  test "sign in with remembering" do 
    sign_in_as(@user, remember_me: '1')
    assert_not_nil cookies['remember_token']
  end

  test "sign in without remembering" do 
    sign_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end

end
