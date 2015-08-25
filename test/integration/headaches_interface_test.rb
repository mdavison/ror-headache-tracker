require 'test_helper'

class HeadachesInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "headache interface" do 
    sign_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # Invalid submission
    assert_no_difference 'Headache.count' do 
      post headaches_path, headache: { headache_date: "" }
    end
    assert_select 'div.alert-danger'
    # Valid submission
    headache_date = Time.zone.today
    assert_difference 'Headache.count', 1 do 
      post headaches_path, headache: { headache_date: headache_date }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match headache_date.strftime("%B %d, %Y"), response.body
    # Delete a headache
    assert_select 'a', text: 'delete'
    first_headache = @user.headaches.paginate(page: 1).first 
    assert_difference 'Headache.count', -1 do 
      delete headache_path(first_headache)
    end
    # Visit a difference user
    get user_path(users(:tom))
    assert_redirected_to root_url
  end

end
