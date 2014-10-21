class Topics::PostsController < ApplicationController
  before_action :get_topic

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    authorize @topic
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
    authorize @post
    if @post.save_with_initial_vote
      flash[:notice] = 'Post was saved.'
      redirect_to [@topic, @post]
    else
      flash[:error] = 'There was an error saving the post. Please try again.'
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = 'Post was updated.'
      redirect_to [@topic, @post]
    else
      flash[:error] = 'There was an error saving the post. Please try again'
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    title = @post.title
    authorize @post
    if @post.destroy
      redirect_to @topic, notice: "\"#{title}\" was deleted successfully."
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end

  private

  def get_topic
    @topic = Topic.find(params[:topic_id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
