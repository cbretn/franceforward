class ThemesController < ApplicationController
  def index
    @themes = Theme.all#.where()
  end

  def show
    @theme = Theme.find(params[:id])
  end
end
