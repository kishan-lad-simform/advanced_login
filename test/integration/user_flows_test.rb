require "test_helper"

class UserFlowsTest < ActionDispatch::IntegrationTest

  def create_user
    @user = User.create(
      email: "test1@example.com", 
      password: "password", 
      username: "demo" )
  end

  def login_user
    post login_path, params: { email: @user.email, password: "password" } 
    assert_redirected_to posts_url
  end

  test "Can't see the welcome page without login" do
    get "/"
    assert_response :redirect
  end

  test "Login to user" do
    get "/"
    create_user
    @user.reload
    login_user
    follow_redirect!
  end

  test "Logout the user" do 
    get "/"
    create_user
    @user.reload
    login_user
    follow_redirect!
    get "/logout"
    assert_redirected_to login_path
    assert_response :redirect
  end
end
