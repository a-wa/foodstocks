class Food < ApplicationRecord
  belongs_to :family
  
  validates :name, presence: true, length: {maximum: 25 }
  validates :quantity, length: {maximum: 10 }
  validates :unit, length: {maximum:10 }
  
end
