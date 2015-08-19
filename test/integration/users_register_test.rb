require 'test_helper'

class UsersRegisterTest < ActionDispatch::IntegrationTest

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

  test "valid registration information" do 
      get register_path
      assert_difference 'User.count', 1 do 
        post_via_redirect users_path, user: { email: "user@example.com",
                                 password: "foobar123456",
                                 password_confirmation: "foobar123456" }
      end
      assert_template 'users/show'
      assert_not flash.empty?
      assert is_signed_in?
    end

end
