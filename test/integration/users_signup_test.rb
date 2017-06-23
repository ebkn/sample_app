require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar"
        }
      }
    end
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name: "hoge",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar"
        }
      }
    end
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name: "hoge",
          email: "user@example.com",
          password: "foo",
          password_confirmation: "bar"
        }
      }
    end
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name: "hoge",
          email: "user@example.com",
          password: "",
          password_confirmation: ""
        }
      }
    end
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name: "",
          email: "user@example.com",
          password: "foobar",
          password_confirmation: "foobar"
        }
      }
    end
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name: "hoge",
          email: "user@invalid",
          password: "foobar",
          password_confirmation: "foobar"
        }
      }
    end
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name: "",
          email: "user@example.com",
          password: "foobar",
          password_confirmation: "foobar"
        }
      }
    end
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name: "",
          email: "user@invalid",
          password: "foobar",
          password_confirmation: "foobar"
        }
      }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert-danger'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {
        user: {
          name: "Example User",
          email: "user@example.com",
          password: "password",
          password: "password"
        }
      }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end
end