class User < ApplicationRecord
  before_save {self.email.downcase! }
  validates :name, presence: true, length: {maximum: 25 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  mount_uploader :image, ImageUploader
    
  belongs_to :family, optional: true
  has_secure_password
  
  has_many :requests
  has_many :guests, through: :requests, source: :guest
  has_many :reverses_of_request, class_name: 'Request', foreign_key: 'guest_id'
  has_many :hosts, through: :reverses_of_request, source: :user
  
  def make_family_id(family)
    self.update(family_id: family.id)
  end
  
  
  def invite(other_user)
    unless self == other_user
      self.requests.create(guest_id: other_user.id, status: 1)
    end
  end
  
  def answer(request_id, status)
    request = self.reverses_of_request.find(request_id)
    request.update(status: status)
  end
  
  def join_family(request_id)
    request = self.reverses_of_request.find(request_id)
    host = User.find(request.user_id)
    self.update(family_id: host.family_id)
  end
  
  has_many :memos
  
  
end
