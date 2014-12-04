class Comment < ActiveRecord::Base
  #belongs_to :user

  # how Rails know where to find this module?
  # because the setting in application.rb
  include Voteable 

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :post

  validates :body, presence: true
end