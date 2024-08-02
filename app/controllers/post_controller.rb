class PostController < ApplicationController
  before_action :find_post, only: %i[show update destroy]

  def index
    render json: Post.all
  end

  def show
    render json: @post
  end

  def create
    Post.create(title: params[:title], content: params[:content])
  end

  def update
    if @post.update(update_params)
      render json: @post
    else
      render json: "Post could not be updated"
    end
  end

  def destroy
    if @post.delete
      render json: "Post deleted"
    else
      render json: "Post could not be deleted"
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def update_params
    params.permit(:title, :content)
  end
end
