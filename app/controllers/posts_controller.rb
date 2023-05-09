class PostsController < ApplicationController
  before_action :set_post, only: %i[destroy edit update]

  def index
    @posts = Post.all
  end

  def new 
      @post = Post.new
  end

  def create 
    @post = Post.new private_params
    #render plain: params
    if @post.save
      redirect_to posts_path 
    else 
      render :new
    end
  end

  def edit; end

  def update
    if @post.update private_params
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  # pohuy
  # Ahahahahahahahha Sasha loh
  private
  def set_post 
    @post = Post.find_by id: params[:id]
  end

  def private_params 
    params.require(:post).permit(:title, :description, :photo, :post_category_id)
  end

end