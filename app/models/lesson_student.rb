class LessonStudent < ApplicationRecord
    belongs_to :lesson
    belongs_to :student
    validate :student_time_validation

    private

    def student_time_validation
      if Lesson.joins(:lesson_students)
        .where('lesson_students.student_id = :student_id', student_id: self.student_id)
        .where('(lessons.start_time <= :end_time) AND (lessons.end_time >= :start_time)', start_time: self.lesson.start_time, end_time: self.lesson.end_time)
        .where('(lessons.start_date <= :end_date) AND (lessons.end_date >= :start_date)', start_date: self.lesson.start_date, end_date: self.lesson.end_date)
        .exists?
          errors.add(:base, 'El profesor tiene otra clase que se superpone en el horario o en el salón')
      end
    end


  end