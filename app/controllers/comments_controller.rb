class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment = current_user.comments.build(comment_params)
    post = Post.find(params[:post_id])
    @comment.post_id = post.id
    if !@comment.save
      flash[:error] = "Error saving comment. Please try again."
    end
    redirect_to [post.topic, post]
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
