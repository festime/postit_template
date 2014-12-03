class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update]

  def index
    @posts = Post.all.sort_by { |post| post.total_votes }.reverse
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
    @post = Post.new(post_params)
    @post.creator = current_user

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

  def vote
    @vote = Vote.new(vote: params[:vote], creator: current_user, voteable: @post)
    @vote.save

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private 

    def post_params
      params.require(:post).permit(:title, :url, :description, category_ids: [])
      # params.require(:post).permit! # permit everything
    end

    def set_post
      # instance variables that set up in before_action are available in actions
      @post = Post.find(params[:id])
    end

    def require_same_user
      if @post.creator != current_user
        flash[:error] = "You're not allowed to do that."
        redirect_to post_path(@post)
      end
    end
end
