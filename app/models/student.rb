class Student < ApplicationRecord
    belongs_to :user

    has_many :lesson_students
    has_many :lessons, through: :lesson_students
  

    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :document_number, presence: true, numericality: { only_integer: true }, uniqueness: true
    validates :first_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
    validates :last_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
    validate :document_number_format


    def full_name
        "#{first_name} #{last_name}"
      end 

      def document_number_format
        if document_number.to_s =~ /\D/
          errors.add(:document_number, "only allows numbers")
        end
      end
    
end
