class ThemesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :all]

  def index
    @category = Category.find(params[:category_id])
    # @themes = Theme.where(category: @category)
    @themes = policy_scope(Theme).where(category: @theme)
  end

  def show
    @theme = Theme.find(params[:id])
    authorize @theme
  end

  def all
    @categories = Category.all
    authorize @categories.first.themes
  end
end
