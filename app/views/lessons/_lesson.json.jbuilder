json.extract! lesson, :id, :name, :code, :start_date, :end_date, :start_time, :end_time, :teacher_id, :lounge_id, :created_at, :updated_at
json.url lesson_url(lesson, format: :json)
