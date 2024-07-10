class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :teacher
  belongs_to :lounge
  has_many :lesson_students, dependent: :destroy
  has_many :students, through: :lesson_students

  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :code, presence: true, numericality: { only_integer: true }, uniqueness: true
  validate :code_format
  validate :end_date_after_start_date
  validate :start_date_not_in_past
  validate :end_time_after_start_time
  validate :time_validation

    def code_format
      if code.to_s =~ /\D/
        errors.add(:code, "only allows numbers")
      end
    end

    def end_date_after_start_date
      return if start_date.blank? || end_date.blank?
  
      if end_date < start_date
        errors.add(:end_date, "cannot be before the start date")
      end
    end
  
    def start_date_not_in_past
      return if start_date.blank?
  
      if start_date < Date.today
        errors.add(:start_date, "cannot be earlier than the current date")
      end
    end

    def end_time_after_start_time
      return if start_time.blank? || end_time.blank?
  
      if end_time <= start_time
        errors.add(:end_time, "must be after the start time")
      end
    end

    private

    def time_validation
      if Lesson.where.not(id: id)
               .where(teacher_id: teacher_id, lounge_id: lounge_id)
               .where('(:start_time BETWEEN start_time AND end_time) OR (:end_time BETWEEN start_time AND end_time)',
                      start_time: start_time, end_time: end_time)
               .where('(:start_date BETWEEN start_date AND end_date) OR (:end_date BETWEEN start_date AND end_date)',
                      start_date: start_date, end_date: end_date)
               .exists?
        errors.add(:base, 'El profesor tiene otra clase que se superpone en el horario o en el salón')
      end
    end

end
