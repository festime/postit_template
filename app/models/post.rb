class Post < ActiveRecord::Base
  # we can type in, e.g., Post.first.user in rails console
  #belongs_to :user 
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments

  has_many :post_categories
  has_many :categories, through: :post_categories
end
