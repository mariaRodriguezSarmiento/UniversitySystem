require "test_helper"

class LoungesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lounge = lounges(:one)
  end

  test "should get index" do
    get lounges_url
    assert_response :success
  end

  test "should get new" do
    get new_lounge_url
    assert_response :success
  end

  test "should create lounge" do
    assert_difference("Lounge.count") do
      post lounges_url, params: { lounge: { code: @lounge.code, name: @lounge.name } }
    end

    assert_redirected_to lounge_url(Lounge.last)
  end

  test "should show lounge" do
    get lounge_url(@lounge)
    assert_response :success
  end

  test "should get edit" do
    get edit_lounge_url(@lounge)
    assert_response :success
  end

  test "should update lounge" do
    patch lounge_url(@lounge), params: { lounge: { code: @lounge.code, name: @lounge.name } }
    assert_redirected_to lounge_url(@lounge)
  end

  test "should destroy lounge" do
    assert_difference("Lounge.count", -1) do
      delete lounge_url(@lounge)
    end

    assert_redirected_to lounges_url
  end
end
