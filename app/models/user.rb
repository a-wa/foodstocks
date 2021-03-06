class User < ApplicationRecord
  before_save {self.email.downcase! }
  validates :name, presence: true, length: {maximum: 25 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
 # validates :password, presence: true, length: {minimum: 8 }, on: :create
  
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
  
  # Requests#create で使用　新規requestを作成 2020/12/29 family_idを追加
  def invite(other_user)
    unless self == other_user
      self.requests.create(guest_id: other_user.id, status: 1, family_id: self.family_id)
    end
  end
  
  # Requests#update で使用　requestのstatusを更新
  def answer(request_id, status)
    request = self.reverses_of_request.find(request_id)
    request.update(status: status)
  end
  
  # Requests#updateで使用　自身のfamily_idを招待者と同じにする 2020/12/29 リクエストしてきたユーザではなくrequestのfamily_idを参照する
  def join_family(request_id)
    request = self.reverses_of_request.find(request_id)
    #host = User.find(request.user_id)
    #self.update(family_id: host.family_id)
    self.update(family_id: request.family_id)
  end
  
  # Users#showアクションで使用 招待中だが未承認のユーザ
  #@guestのところ
  #def inviting_users
  #  requests = Request.where(user_id: self.id, status: 1)
  #  guest_ids = requests.pluck(:guest_id)
  #  User.where(id: guest_ids)
  #end
  
  #つかえないよーーー！！！
  #わからないのでViewに直接書く
  #def host_email
  #  user = User.find(self.guest_id)
  #  user.email
  #end
  
  
  #「招待中のユーザ」未承認のリクエスト　2020/12/29 自分以外の家族が送ったリクエストも含めるように変更
  def requestings
    Request.where(status: 1, family_id: self.family_id)
  end
  
  
  has_many :memos
  
  
end
