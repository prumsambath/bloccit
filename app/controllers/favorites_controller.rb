class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post)
    authorize favorite

    if favorite.save
      flash[:notice] = "\"#{@post.title}\" has been starred."
    else
      flash[:error] = "There is an error starring the post."
    end
    redirect_to [@post.topic, @post]
  end

  def destroy
    @post = Post.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])
    authorize favorite

    if favorite.destroy
      flash[:notice] = "\"#{@post.title}\" has been unstarred."
    else
      flash[:error] = "There is an error unstarring the post."
    end
    redirect_to [@post.topic, @post]
  end
end
