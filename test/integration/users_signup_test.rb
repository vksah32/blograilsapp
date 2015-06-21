require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid_users-signup' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {name: "", email: 'la@lala', password: "foo", password_confirmation: "bar"}
    end
    assert_template 'users/new'
                      
  end
  
  test 'valid_users-signup' do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: {name: "lala", email: 'la@lala.com', password: "foobar", 
                                              password_confirmation: "foobar"}
    end
    assert_template 'users/show'
                      
  end
end
