class CommentsController < ApplicationController
  # def create
  #   @post = Post.find(params[:post_id])
  #   @comment = @post.comments.build(params.require(:comment).permit(:body))

  #   if @comment.save
  #     flash[:notice] = "Your comment was added"
  #     redirect_to post_path(@post)
  #   else
  #     render 'posts/show'
  #   end
  # end
  before_action :require_user

  def create
    # binding.pry

    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
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
    vote = Vote.new(vote: params[:vote], creator: current_user, 
                    voteable: Comment.find(params[:id]))

    flash[:error] = "Sorry, you can only vote this comment once." if !vote.save

    redirect_to :back
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end