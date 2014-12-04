module Sluggable
  extend ActiveSupport::Concern 

  included do
    before_save :generate_slug
  end

  def generate_slug
    # a symbol stands for the name of slug column
    slug_column = self.class.slug_column 
    
    count = self.class.all.select do |obj|
      obj.send(slug_column).downcase == self.send(slug_column).downcase
    end.count
    # count = self.class.where(slug_column => self.send(slug_column).downcase).count

    new_slug = self.send(slug_column).gsub(" ", "-").downcase + 
               (count == 0 ? '' : '-' + count.to_s)

    self.slug = new_slug
  end

  def to_param
    self.slug 
  end  
end