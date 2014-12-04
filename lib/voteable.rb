# using concerns
module Voteable
  extend ActiveSupport::Concern 

  included do 
    has_many :votes, as: :voteable
  end

  def total_votes
    up_votes - down_votes
  end

  def up_votes
    self.votes.where(vote: true).count
  end

  def down_votes
    self.votes.where(vote: false).count
  end  
end

# using normal metaprogramming
=begin
module Voteable
  def self.included(base)
    # the instance methods in InstanceMethods will be included
    base.send(:include, InstanceMethods) 
    base.extend ClassMethods
    base.class_eval do 
      my_class_method
    end
  end

  module InstanceMethods
    def total_votes
      up_votes - down_votes
    end

    def up_votes
      self.votes.where(vote: true).count
    end

    def down_votes
      self.votes.where(vote: false).count
    end
  end

  module ClassMethods
    def my_class_method
      has_many :votes, as: :voteable 
    end
  end
end
=end