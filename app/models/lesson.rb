class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :teacher
  belongs_to :lounge
  has_many :lesson_students, dependent: :destroy
  has_many :students, through: :lesson_students

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  validate :availability_check

  private
  def availability_check
    if teacher_id.present? && lounge_id.present?
      # Query to check for overlapping lessons
      overlapping_lessons = Lesson.where.not(id: id).where(
        "(teacher_id = :teacher_id OR lounge_id = :lounge_id) AND " +
        "((start_time BETWEEN :start_time AND :end_time) OR " +
        "(end_time BETWEEN :start_time AND :end_time) OR " +
        "(:start_time BETWEEN start_time AND end_time) OR " +
        "(:end_time BETWEEN start_time AND end_time))",
        teacher_id: teacher_id, lounge_id: lounge_id,
        start_time: start_time, end_time: end_time
      )

      if overlapping_lessons.exists?
        errors.add(:base, 'Teacher or lounge is not available during this time')
      end
    end
  end
end
