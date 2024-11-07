class PostsController < ApplicationController
  include Pagy::Backend

  before_action :authenticate_user!, only: %i[new create edit update destroy my_posts]
  before_action :set_post, only: %i[destroy edit show update]
  before_action :authorize_post, only: %i[show edit destroy]

  include Pagy::Frontend

  def index
    @pagy, @posts = pagy_countless(Post.order(created_at: :desc), items: 10)


    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end





  def new 
      @post = Post.new
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace( "post_creation", partial: "posts/new", locals: { post: @post })
        }
        format.html
      end
  end

  def show
    @comments = @post.comments
  end

  def my_posts
    @my_posts = current_user.posts


  end

  def create
    @post = current_user.posts.create private_params
    if @post.save
      respond_to do |format|
        format.html {
          redirect_to posts_path
        }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend("posts", partial: "posts/post", locals: { post: @post }),
            turbo_stream.replace("post_creation", partial: "posts/create")
          ]
        end
      end
    else
      respond_to do |format|
        format.html {
          render :new
        }
        format.turbo_stream {

        }
      end
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def update
    if @post.update private_params
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace( @post, partial: "posts/post", locals: { post: @post }) }

        format.html
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@post) }
      format.html { redirect_to posts_path, notice: 'Post was successfully deleted.' }
    end
  end


  private

  def authorize_post
    authorize @post  # Викликаємо authorize з Pundit для @post
  end

  def set_post 
    @post = Post.find_by id: params[:id]
  end

  def private_params 
    params.require(:post).permit(:title, :description, :photo, :post_category_id)
  end

end