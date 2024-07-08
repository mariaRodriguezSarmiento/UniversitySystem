class Lounge < ApplicationRecord
    belongs_to :user
    has_many :lessons
    
    validates :code, presence: true, numericality: { only_integer: true }, uniqueness: true 
    validates :name, presence: true
end
