class ActionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_action, only: [:show, :edit, :update, :destroy]
  # require 'pry-byebug'

  def index
    @theme = Theme.find(params[:theme_id])
    @actions = policy_scope(Action).where(theme: @theme)
  end

  def new
    @theme = Theme.find(params[:theme_id])
    @category = @theme.category
    @action = Action.new
    authorize @action
  end

  def create
    # binding.pry
    @action = Action.new(action_params)
    @theme = Theme.find(params[:theme_id])
    @action.theme = @theme
    @action.user = current_user
    authorize @action
    if @action.save!
      redirect_to category_theme_discussion_path(@theme.category, @theme, @action)
    else
      render :new
    end
  end

  def show
    authorize @action
  end

  def edit
    authorize @action
    @theme = @action.theme
    @category = @theme.category
  end

  def update
    authorize @action
    if @action.update(action_params)
      redirect_to category_theme_action_path(@action.theme.category, @action.theme, @action)
    else
      render :edit
    end
  end

  def destroy
    authorize @action
    @action = Action.find(params[:id])
    @theme = @action.theme
    @action.destroy
    redirect_to category_theme_path(@theme.category, @theme)
  end

  private

  def set_action
    @action = Action.find(params[:id])
  end

  def action_params
    # params.require(:action).permit(:location, :title, :description, :start_date, :end_date, :description)
    params.require(:action).permit(:title, :location, :start_date, :end_date, :description)
  end
end
