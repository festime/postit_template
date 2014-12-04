class Category < ActiveRecord::Base

  include Sluggable

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true

  # def generate_slug
  #   self.slug = self.name.gsub(" ", "-").downcase
  # end

  # def to_param
  #   self.slug
  # end
end
