class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator_or_admin, only: [:edit, :update]

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
      format.html { redirect_to :back } # handle HTML request
      format.js # handle javascript request
      # by default, in action, Rails will render a template with the same name
      # as this action. 
      # In this case, the name of this template is called vote.
    end
  end

  private 

    def post_params
      params.require(:post).permit(:title, :url, :description, category_ids: [])
      # params.require(:post).permit! # permit everything
    end

    def set_post
      # instance variables that set up in before_action are available in actions
      @post = Post.find_by(slug: params[:id])
    end

    def require_creator_or_admin
      if @post.creator != current_user && !current_user.admin?
        flash[:error] = "You're not allowed to do that."
        redirect_to post_path(@post)
      end
    end
end
