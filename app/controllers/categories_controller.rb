class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    # @categories = Category.all
    @categories = policy_scope(Category)
  end

  def show
    @category = Category.find(params[:id])
    authorize @category
  end
end
