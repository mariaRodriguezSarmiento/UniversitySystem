class Lounge < ApplicationRecord
    belongs_to :user
    has_many :lessons

    validates :code, presence: true, numericality: { only_integer: true }, uniqueness: true
    validates :name, presence: true
    validate :code_format
    
      def code_format
        if code.to_s =~ /\D/
          errors.add(:code, "only allows numbers")
        end
      end

end
