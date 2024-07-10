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
  validate :teacher_and_lounge_availability
    def code_format
      if code.to_s =~ /\D/
        errors.add(:code, "debe contener solo números")
      end
    end

    def end_date_after_start_date
      return if start_date.blank? || end_date.blank?
  
      if end_date < start_date
        errors.add(:end_date, "no puede ser anterior a la fecha de inicio")
      end
    end
  
    def start_date_not_in_past
      return if start_date.blank?
  
      if start_date < Date.today
        errors.add(:start_date, "no puede ser anterior a la fecha actual")
      end
    end

    def end_time_after_start_time
      return if start_time.blank? || end_time.blank?
  
      if end_time <= start_time
        errors.add(:end_time, "debe ser posterior a la hora de inicio")
      end
    end

    def teacher_and_lounge_availability
      if Lesson.where( '(? <= end_date OR ? >= start_date OR ? < end_time OR ? > start_time) AND (teacher_id = ? OR lounge_id = ?)',end_date,start_date,end_time,start_time,teacher_id,lounge_id).exists?
        errors.add(:base, "debe empezar con mayúscula")
      end
    end
end
