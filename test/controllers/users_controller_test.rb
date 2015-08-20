require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:michael)
    @other_user = users(:tom)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect index when not signed in" do 
    get :index
    assert_redirected_to signin_url
  end

  test "should redirect show when not signed in" do
    get :show, id: @user 
    assert_not flash.empty?
    assert_redirected_to signin_url
  end

  test "should redirect edit when not signed in" do
    get :edit, id: @user 
    assert_not flash.empty?
    assert_redirected_to signin_url
  end

  test "should redirect update when not signed in" do 
    patch :update, id: @user, user: { email: @user.email }
    assert_not flash.empty?
    assert_redirected_to signin_url
  end

  test "should redirect show when signed in as wrong user" do
    sign_in_as(@other_user)
    get :show, id: @user 
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect edit when signed in as wrong user" do
    sign_in_as(@other_user)
    get :edit, id: @user 
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when signed in as wrong user" do 
    sign_in_as(@other_user)
    patch :update, id: @user, user: { email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should not allow the admin attribute to be edited via the web" do 
    sign_in_as(@other_user)
    assert_not @other_user.admin?
    patch :update, id: @other_user, 
                   user: { password: "password12345", 
                           password_confirmation: "password12345",
                           admin: '1' }
    assert_not @other_user.reload.admin?
  end

  test "should redirect destroy when not signed in" do 
    assert_no_difference 'User.count' do 
      delete :destroy, id: @user 
    end
    assert_redirected_to signin_url
  end

  test "should redirect destroy when signed in as a non-admin" do 
    sign_in_as(@other_user)
    assert_no_difference 'User.count' do 
      delete :destroy, id: @user 
    end
    assert_redirected_to root_url
  end

end
