class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :document_number, presence: true, numericality: { only_integer: true }, uniqueness: true
  validates :first_name, :last_name, :password, presence: true  

end
