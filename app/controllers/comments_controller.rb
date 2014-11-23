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

  def create
    # binding.pry

    @comment = Comment.new(comment_params)
    @comment.post_id = params[:post_id]
    @comment.creator = User.first # TODO: fix after authentication
    # @comment = @post.comments.build(comment_params) 

    if @comment.save
      flash[:notice] = "You left a comment."
      redirect_to post_path(params[:post_id])
    else 
      @post = Post.find(params[:post_id])
      render "posts/show" # posts/show needs @post
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end

  def create
    @comment = Comment.new(params.require(:comment).permit(:body))

    if @comment.save
      flash[:notice] = ""
      redirect_to
    else
      render "posts/show"
    end
  end