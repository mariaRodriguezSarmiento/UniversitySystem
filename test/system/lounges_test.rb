require "application_system_test_case"

class LoungesTest < ApplicationSystemTestCase
  setup do
    @lounge = lounges(:one)
  end

  test "visiting the index" do
    visit lounges_url
    assert_selector "h1", text: "Lounges"
  end

  test "should create lounge" do
    visit lounges_url
    click_on "New lounge"

    fill_in "Code", with: @lounge.code
    fill_in "Name", with: @lounge.name
    click_on "Create Lounge"

    assert_text "Lounge was successfully created"
    click_on "Back"
  end

  test "should update Lounge" do
    visit lounge_url(@lounge)
    click_on "Edit this lounge", match: :first

    fill_in "Code", with: @lounge.code
    fill_in "Name", with: @lounge.name
    click_on "Update Lounge"

    assert_text "Lounge was successfully updated"
    click_on "Back"
  end

  test "should destroy Lounge" do
    visit lounge_url(@lounge)
    click_on "Destroy this lounge", match: :first

    assert_text "Lounge was successfully destroyed"
  end
end
