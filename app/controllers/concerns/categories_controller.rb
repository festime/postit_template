class CategoriesController < ApplicationController
  before_action :require_user, only: [:new, :create]
  
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
    @category = Category.find(params[:id])
  end

  private

    def category_params
      params.require(:category).permit(:name)
    end
end