require "test_helper"

class AdminFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers 
 
  def create_admin
    @admin = Admin.create(
      email: "admintest@gmail.com",
      password: "admin123"
    )
  end

  def login_admin 
    get "/admins/sign_in"
    create_admin
    sign_in(@admin)
    get dashboards_path 
    assert_response :success
    assert_select "h1", "Admin Dashboard"
  end

  test "Should not access index page without login" do
    get dashboards_path
    assert_redirected_to "/admins/sign_in"
    assert_response :redirect
  end

  test "Login admin" do 
    login_admin
  end

  test "Logout admin" do 
    login_admin
    sign_out(@admin)
    get dashboards_path
    assert_response :redirect
    assert_redirected_to new_admin_session_path
  end

end
