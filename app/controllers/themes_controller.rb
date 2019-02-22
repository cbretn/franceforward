class ThemesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :all]

  def index
    @category = Category.find(params[:category_id])
    @themes = Theme.where(category: @category)
  end

  def show
    @theme = Theme.find(params[:id])
  end

  def all
    @themes = Theme.all
  end
end
