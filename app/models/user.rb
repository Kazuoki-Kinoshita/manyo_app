class User < ApplicationRecord
  before_validation { email.downcase! }
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
            format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
            uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 } ,on: :create
  has_many :tasks, dependent: :destroy
  before_update :admin_can_not_update
  before_destroy :admin_can_not_delete


  private

  def admin_can_not_update
    #　管理者権限のユーザが1人かつ、管理者権限を持つ最初のレコードがself(@user)、かつself(@user)が管理者権限がなかった場合
    admin_users = User.where(admin: true)
    if admin_users.count == 1 && admin_users.first == self && !(self.admin?)
      errors.add(:base, "最後の管理者は編集できません！")
      throw :abort 
    end
  end
  
  def admin_can_not_delete
    #　self(@user)が管理者権限を持っている、かつ管理者権限のユーザが1人だけだった場合
    throw :abort if self.admin? && User.where(admin: true).count == 1
  end
end