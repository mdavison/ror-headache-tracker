require 'test_helper'

class UsersHeadachesTest < ActionDispatch::IntegrationTest

  def setup 
    @user = users(:michael)
  end

  # test "headaches display" do
  #   get user_path(@user)
  #   assert_not @user.admin?
  #   assert_template 'users/show'
  #   assert_select 'h3', text: @user.email
  #   assert_match @user.headaches.count.to_s, response.body
  #   assert_select 'div.pagination'
  #   @user.headaches.paginate(page: 1).each do |headache|
  #     assert_match headache.headache_date, response.body
  #   end
  # end

end
