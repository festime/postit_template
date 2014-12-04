module Sluggable
  extend ActiveSupport::Concern 

  included do
    before_save :generate_slug
  end

  def generate_slug
    if self.instance_of? Post
      count = Post.all.select do |post| 
        post.title.downcase == self.title.downcase
      end.count

      new_slug = self.title.gsub(" ", "-").downcase + 
                 (count == 0 ? '' : '-' + count.to_s)

      self.slug = new_slug

    elsif self.instance_of? User
      count = User.all.select do |user| 
        user.username.downcase == self.username.downcase 
      end.count

      new_slug = self.username.gsub(" ", "-").downcase + 
                 (count == 0 ? '' : '-' + count.to_s)

      self.slug = new_slug

    elsif self.instance_of? Category
      count = Category.all.select do |cate|
        cate.name.downcase == self.name.downcase
      end.count

      new_slug = self.name.gsub(" ", "-").downcase + 
                 (count == 0 ? '' : '-' + count.to_s)

      self.slug = new_slug
    end
  end

  def to_param
    self.slug 
  end  
end