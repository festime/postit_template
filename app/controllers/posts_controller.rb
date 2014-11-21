class PostsController < ApplicationController
  def index
    binding.pry
    @posts = Post.all 
    # by default, Rails will render the index template
  end

  def show
    @post = Post.find(params[:id])
    # by default, Rails will render the show template
  end

  def new
  end

  def create
  end

  def edit

  end

  def update
  end
end
