require 'test_helper'

class HeadachesControllerTest < ActionController::TestCase

  def setup
    @headache = headaches(:one)
  end

  test "should redirect create when not logged in" do 
    assert_no_difference 'Headache.count' do 
      post :create, headache: { headache_date: Time.zone.today }
    end
    assert_redirected_to signin_url
  end

  test "should redirect destroy when not logged in" do 
    assert_no_difference 'Headache.count' do 
      delete :destroy, id: @headache 
    end
    assert_redirected_to signin_url    
  end

  test "should redirect destroy for wrong user's headache" do 
    sign_in_as(users(:michael))
    headache = headaches(:another_one) # this is tom's headache
    assert_no_difference 'Headache.count' do 
      delete :destroy, id: headache 
    end
    assert_redirected_to root_url
  end

end
