require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_registration_url
    assert_response :success
    assert_select "form"
  end

  test "should not create user with valid parameters" do
    assert_no_difference("User.count") do
      post registrations_url, params: { user: { email_address: "test@example.com", password: "password123", password_confirmation: "password123" } }
    end
    assert_equal new_registration_url, response.location
    assert_equal "Sign-ups are currently disabled.", flash[:alert]
    assert_response :forbidden
  end

  test "should not create user with invalid parameters" do
    assert_no_difference("User.count") do
      post registrations_url, params: { user: { email_address: "", password: "password123", password_confirmation: "password123" } }
    end
    assert_equal new_registration_url, response.location
    assert_equal "Sign-ups are currently disabled.", flash[:alert]
    assert_response :forbidden
  end
end
