class PostCategoriesController< ApplicationController 
  before_action :find_category, only: %i[edit update destroy]

  def index 
    @categories = PostCategory.all
  end
  def new 
    @category = PostCategory.new
  end
  def create 
    @category = PostCategory.new post_category_params
    if @category.save
      redirect_to post_categories_path
    else
      redirect_to new_post_category_path
    end
  end

  def edit 
  end
  def update 
    if @category.update
      redirect_to post_categories_path
    else
      render:edit
    end
  end
  def show 
   find_category
    @posts = Post.where(post_category_id: @category.id)
  end

  def destroy  
   
    @category.destroy
    redirect to post_categories_path
  end
  private 
  def find_category 
    @category = PostCategory.find_by id: params[:id]
  end

 
  def post_category_params  
    params.require(:post_category).permit(:name , :description)
  end

end