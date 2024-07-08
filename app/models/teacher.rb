class Teacher < ApplicationRecord
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :document_number, presence: true, numericality: { only_integer: true }, uniqueness: true
    validates :first_name, :last_name, presence: true
end
