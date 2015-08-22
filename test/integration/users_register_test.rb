require 'test_helper'

class UsersRegisterTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end

  test "invalid registration information" do 
    get register_path
    assert_no_difference 'User.count' do 
      post users_path, user: { email: "user@invalid",
                               password: "foo",
                               password_confirmation: "bar" }
    end
    assert_template 'users/new'
    assert_select 'div.alert'
  end

  test "valid registration information with account activation" do 
      get register_path
      assert_difference 'User.count', 1 do 
        post users_path, user: { email: "user@example.com",
                                 password: "foobar123456",
                                 password_confirmation: "foobar123456" }
      end
      assert_equal 1, ActionMailer::Base.deliveries.size
      user = assigns(:user)
      assert_not user.activated?
      # Try to sign in before activation
      sign_in_as(user)
      assert_not is_signed_in?
      # Invalid activation token
      get edit_account_activation_path("invalid token")
      assert_not is_signed_in?
      # Valid token, wrong email
      get edit_account_activation_path(user.activation_token, email: 'wrong')
      assert_not is_signed_in?
      # Valid activation token
      get edit_account_activation_path(user.activation_token, email: user.email)
      assert user.reload.activated?
      follow_redirect!
      assert_template 'users/show'
      assert is_signed_in?      
    end

end
