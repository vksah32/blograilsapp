require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name:"Vivek" , email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @user.valid?
    
  end
  
  test "should have a name" do
    @user.name = "   "
    assert_not @user.valid?
  end  
  
  test "should have an email" do
    @user.email = "   "
    assert_not @user.valid?
  end
  
  
  test "name should be too long" do
    @user.name = "a"*51
    assert_not @user.valid?
  end
 
  test "email should be too long" do
    @user.name = "a"*244+"example.com"
    assert_not @user.valid?
  end
  
  test "email validation should accept valid email addresses" do
    valid_addresses= %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert_not @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  
  test "user email should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email =@user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "password should be present" do
    @user.password = @user.password_confirmation = " " *6
    assert_not @user.valid?
  end
  
  test "password should have minimum length" do
    @user.password = @user.password_confirmation = "a" *5
     assert_not @user.valid?
  end
  
end
