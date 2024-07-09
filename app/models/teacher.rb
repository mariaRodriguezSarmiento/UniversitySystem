class Teacher < ApplicationRecord
    belongs_to :user

    has_many :lessons

    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :document_number, presence: true, numericality: { only_integer: true }, uniqueness: true
    validates :first_name, presence: true
    validates :last_name, presence: true

    def full_name
        "#{first_name} #{last_name}"
      end
      
    end