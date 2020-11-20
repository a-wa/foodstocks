class Memo < ApplicationRecord
  belongs_to :user
  belongs_to :family
  
  validates :content, presence: true, length: {maximum: 255 }
end
