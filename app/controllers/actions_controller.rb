class ActionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_action, only: [:show, :edit, :update]

  def index
    @theme = Theme.find(params[:theme_id])
    @actions = policy_scope(action).where(theme: @theme)
  end

  def new
    @action = action.new
    @theme = Theme.find(params[:theme_id])
    authorize @action
  end

  def create
    @action = action.new(action_params)
    @theme = Theme.find(params[:theme_id])
    @action.theme = @theme
    @action.user = current_user
    authorize @action
    if @action.save!
      redirect_to theme_reviews_path(@theme)
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    authorize @action
    if @action.update(action_params)
      redirect_to action_path(@action)
    else
      render :edit
    end
  end

  def destroy
    authorize @action
    @action = action.find(params[:id])
    # @theme = @action.theme
    @action.destroy
    redirect_to theme_path(@theme)
  end

  private

  def set_action
    @action = action.find(params[:id])
  end

  def action_params
    params.require(:action).permit(:content, :title)
  end
end
