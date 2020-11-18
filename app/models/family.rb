class Family < ApplicationRecord
    validates :name, presence: true, length: {maximum:25 }
    
  has_many :users
  has_many :foods
    

end
