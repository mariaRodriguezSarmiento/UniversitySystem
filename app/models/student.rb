class Student < ApplicationRecord
    belongs_to :user

    has_many :lesson_students
    has_many :lessons, through: :lesson_students
  

    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :document_number, presence: true, numericality: { only_integer: true }, uniqueness: true
    validates :first_name, :last_name, presence: true

    validate :no_duplicate_lessons_at_same_time

    def full_name
        "#{first_name} #{last_name}"
      end 
      
    private
 
    def no_duplicate_lessons_at_same_time
        lesson_times = lessons.pluck(:start_time, :end_time)
    
        lesson_times.each do |start_time, end_time|
          if overlaps_with_other_lessons?(start_time, end_time)
            errors.add(:base, "Student cannot be enrolled in more than one lesson at the same time")
            break
          end
        end
      end
    
      def overlaps_with_other_lessons?(start_time, end_time)
        lesson_times = lessons.where.not(id: self.id).pluck(:start_time, :end_time)
    
        lesson_times.any? do |existing_start_time, existing_end_time|
          start_time < existing_end_time && end_time > existing_start_time
        end
      end
end
