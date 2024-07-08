require "test_helper"

class LessonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lesson = lessons(:one)
  end

  test "should get index" do
    get lessons_url
    assert_response :success
  end

  test "should get new" do
    get new_lesson_url
    assert_response :success
  end

  test "should create lesson" do
    assert_difference("Lesson.count") do
      post lessons_url, params: { lesson: { code: @lesson.code, end_date: @lesson.end_date, end_time: @lesson.end_time, lounge_id: @lesson.lounge_id, name: @lesson.name, start_date: @lesson.start_date, start_time: @lesson.start_time, teacher_id: @lesson.teacher_id } }
    end

    assert_redirected_to lesson_url(Lesson.last)
  end

  test "should show lesson" do
    get lesson_url(@lesson)
    assert_response :success
  end

  test "should get edit" do
    get edit_lesson_url(@lesson)
    assert_response :success
  end

  test "should update lesson" do
    patch lesson_url(@lesson), params: { lesson: { code: @lesson.code, end_date: @lesson.end_date, end_time: @lesson.end_time, lounge_id: @lesson.lounge_id, name: @lesson.name, start_date: @lesson.start_date, start_time: @lesson.start_time, teacher_id: @lesson.teacher_id } }
    assert_redirected_to lesson_url(@lesson)
  end

  test "should destroy lesson" do
    assert_difference("Lesson.count", -1) do
      delete lesson_url(@lesson)
    end

    assert_redirected_to lessons_url
  end
end