class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all 
    # by default, Rails will render the index template
  end

  def show
    @comment = Comment.new
  # by default, Rails will render the show template
  end

  def new
    @post = Post.new
  end

  def create
    # binding.pry
    @post = Post.new(post_params)
    @post.creator = User.first # TODO: change once we have authentication

    if @post.save
      flash[:notice] = "You have created a new post."
      redirect_to post_path(@post)
    else 
      render :new
    end 
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "You have updated this post."
      redirect_to post_path(@post)
    else 
      render :edit
    end
  end

  private 

    def post_params
      params.require(:post).permit(:title, :url, :description)
      # params.require(:post).permit! # permit everything
    end

    def set_post
      # instance variables that set up in before_action are available in actions
      @post = Post.find(params[:id])
    end
end
