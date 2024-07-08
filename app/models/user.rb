class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :teachers
  has_many :students
  has_many :lounges
  has_many :lessons
  
  validates :document_number, presence: true, numericality: { only_integer: true }, uniqueness: true
  validates :first_name, :last_name, :password, presence: true  


  def full_name
    "#{first_name} #{last_name}"
  end
  
end
