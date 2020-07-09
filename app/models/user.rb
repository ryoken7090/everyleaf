class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: true
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy
  enum admin: { 管理者: true, 一般ユーザー: false }
  before_destroy :check_admin_existence

  def check_admin_existence
    if self.admin == "管理者"
      if User.where(admin: "管理者").count == 1
        throw :abort, notice: '少なくとも1つ、管理者アカウントが必要です'
      end
    end
  end

end
