require "application_system_test_case"

class LessonsTest < ApplicationSystemTestCase
  setup do
    @lesson = lessons(:one)
  end

  test "visiting the index" do
    visit lessons_url
    assert_selector "h1", text: "Lessons"
  end

  test "should create lesson" do
    visit lessons_url
    click_on "New lesson"

    fill_in "Code", with: @lesson.code
    fill_in "End date", with: @lesson.end_date
    fill_in "End time", with: @lesson.end_time
    fill_in "Lounge", with: @lesson.lounge_id
    fill_in "Name", with: @lesson.name
    fill_in "Start date", with: @lesson.start_date
    fill_in "Start time", with: @lesson.start_time
    fill_in "Teacher", with: @lesson.teacher_id
    click_on "Create Lesson"

    assert_text "Lesson was successfully created"
    click_on "Back"
  end

  test "should update Lesson" do
    visit lesson_url(@lesson)
    click_on "Edit this lesson", match: :first

    fill_in "Code", with: @lesson.code
    fill_in "End date", with: @lesson.end_date
    fill_in "End time", with: @lesson.end_time
    fill_in "Lounge", with: @lesson.lounge_id
    fill_in "Name", with: @lesson.name
    fill_in "Start date", with: @lesson.start_date
    fill_in "Start time", with: @lesson.start_time
    fill_in "Teacher", with: @lesson.teacher_id
    click_on "Update Lesson"

    assert_text "Lesson was successfully updated"
    click_on "Back"
  end

  test "should destroy Lesson" do
    visit lesson_url(@lesson)
    click_on "Destroy this lesson", match: :first

    assert_text "Lesson was successfully destroyed"
  end
end
