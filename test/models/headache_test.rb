require 'test_helper'

class HeadacheTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @headache = @user.headaches.build(headache_date: Time.zone.today)
  end

  test "should be valid" do 
    assert @headache.valid?
  end

  test "user id should be present" do 
    @headache.user_id = nil
    assert_not @headache.valid?
  end

  test "headache_date should be present" do 
    @headache.headache_date = " "
    assert_not @headache.valid?
  end

  test "order should be most recent first" do 
    assert_equal headaches(:most_recent), Headache.order(headache_date: :desc).first
  end

end
