class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]
  before_action :require_admin, only: [:new, :create]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "You created a new category."
      redirect_to :root
    else 
      render :new
    end
  end

  def show
    @category = Category.find_by(slug: params[:id])
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end

    def require_admin
      if !logged_in? || !current_user.admin?
        flash[:error] = "Only administrators can create new category."
        redirect_to root_path 
      end
    end
end