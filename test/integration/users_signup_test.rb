require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
  assert_select 'div.alert.alert-danger'
  assert_select "li", "Name can't be blank"
  assert_select "li", "Email is invalid"
  assert_select "li", "Password confirmation doesn't match Password"
  min_validation = User.validators_on(:password).find do |v|
    v.options.key?(:minimum)
  end
  min_length = min_validation.options[:minimum]
  assert_select "li", "Password is too short (minimum is #{min_length} characters)"
end
test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end
