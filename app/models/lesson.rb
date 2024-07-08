class Lesson < ApplicationRecord
  
  belongs_to :teacher
  belongs_to :lounge
  has_many :lesson_students
  has_many :students, through: :lesson_students

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :validate_time_range
  validate :validate_teacher_schedule
  validate :validate_lounge_availability

  private

  def validate_time_range
    if start_time && end_time && start_time >= end_time
      errors.add(:end_time, "must be after start time")
    end
  end

  def validate_teacher_schedule
    if teacher_id.present? && teacher_has_conflicting_lesson?
      errors.add(:base, 'Teacher has conflicting lesson schedule')
    end
  end

  def teacher_has_conflicting_lesson?
    overlapping_lessons = teacher.lessons.where.not(id: id)
                              .where('start_date <= ? AND end_date >= ?', end_date, start_date)
                              .where('((start_time <= ? AND end_time > ?) OR (start_time < ? AND end_time >= ?))',
                                     end_time, end_time, start_time, start_time)

    overlapping_lessons.exists?
  end

  def validate_lounge_availability
    if lounge_id.present? && lounge_has_conflicting_lesson?
      errors.add(:base, 'Lounge has conflicting lesson schedule')
    end
  end

  def lounge_has_conflicting_lesson?
    overlapping_lessons = lounge.lessons.where.not(id: id)
                              .where('start_date <= ? AND end_date >= ?', end_date, start_date)
                              .where('((start_time <= ? AND end_time > ?) OR (start_time < ? AND end_time >= ?))',
                                     end_time, end_time, start_time, start_time)

    overlapping_lessons.exists?
  end
  
end