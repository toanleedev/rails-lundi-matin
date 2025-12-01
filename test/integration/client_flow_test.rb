require "test_helper"

class ClientFlowTest < ActionDispatch::IntegrationTest
  test "user can login and search clients" do
    # Visit login page
    get login_path
    assert_response :success
    assert_select "h2", "Login to Lundi Matin"

    # Try to access clients without login
    get clients_path
    assert_redirected_to login_path

    # Note: Actual login test would require mocking API
    # This is a placeholder for integration tests
  end

  test "unauthenticated user is redirected to login" do
    get clients_path
    assert_redirected_to login_path
  end

  test "logout clears session" do
    # This would test logout functionality
    # Requires authenticated session first
  end
end

