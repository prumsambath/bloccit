class CommentsController < ApplicationController
  respond_to :html, :js

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

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed."
    else
      flash[:error] = "Comment couldn't be deleted. Please try again."
    end

    respond_with(@comment) do |format|
      format.html { redirect_to [@post.topic, @post] }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
