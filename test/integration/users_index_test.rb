require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup 
    @admin = users(:michael)
    @non_admin = users(:tom)
  end

  test "index" do 
    sign_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'a[href=?]', users_path
    User.all.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.email
      unless user == @admin 
        assert_select 'a[href=?]', user_path(user), text: 'delete'        
      end
    end
    assert_difference 'User.count', -1 do 
      delete user_path(@non_admin)
    end
  end

end
