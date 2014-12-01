class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true

  # User object has virtial attribute password
  # this validation 在 create 以外的 actions 不會觸發
  # 例如在更新使用者資料的時候，因為資料庫不存使用者的密碼，所以密碼欄位是空的
  # 如果使用者想維持原本密碼，讓這欄位為空，就不會有任何驗證錯誤
  validates :password, presence: true, on: :create, length: {minimum: 5}
end