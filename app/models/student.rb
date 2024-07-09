class Student < ApplicationRecord
    belongs_to :user

    has_many :lesson_students
    has_many :lessons, through: :lesson_students
  

    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :document_number, presence: true, numericality: { only_integer: true }, uniqueness: true
    validates :first_name, :last_name, presence: true


    def full_name
        "#{first_name} #{last_name}"
      end 
    
end
