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
  validates :password, presence: true  
  validates :first_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :last_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }


  def full_name
    "#{first_name} #{last_name}"
  end
  
end
