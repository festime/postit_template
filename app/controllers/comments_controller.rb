class CommentsController < ApplicationController
  before_action :require_user

  def create
    binding.pry

    @comment = Comment.new(comment_params)
    @comment.post = Post.find_by(slug: params[:post_id])
    @comment.creator = current_user
    # @comment = @post.comments.build(comment_params) 

    if @comment.save
      flash[:notice] = "You left a comment."
      redirect_to post_path(params[:post_id])
    else 
      @post = Post.find(params[:post_id])
      render "posts/show" # posts/show needs @post
    end
  end

  def vote
    @vote = Vote.new(vote: params[:vote], creator: current_user, 
                     voteable: Comment.find(params[:id]))
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

    def comment_params
      params.require(:comment).permit(:body)
    end
end