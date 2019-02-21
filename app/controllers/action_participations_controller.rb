class ActionParticipationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_action_participation, only: [:show, :edit, :update]

  def index
    @action = Action.find(params[:action_id])
    @action_participations = policy_scope(action_participations).where(action: @action)
  end

  def new
    @action_participation = ActionParticipation.new
    @action = Action.find(params[:action_id])
    authorize @action
  end

  def create
    @action_participation = ActionParticipation.new(action_participation_params)
    @action = Action.find(params[:action_id])
    @action_participation.action = @action
    @action_participation.user = current_user
    authorize @action_participation
    if @action_participation.save!
      redirect_to action_participations_path(@action)
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    authorize @action_participation
    if @action_participation.update(action_participation_params)
      redirect_to action_path(@action_participation.action)
    else
      render :edit
    end
  end

  def destroy
    authorize @action_participation
    @action_participation = ActionParticipation.find(params[:id])
    @action = @action_participation.action
    # @theme = @action.theme
    @action_participation.destroy
    redirect_to theme_path(@action)
  end

  private

  def set_action_participation
    @action_participation = ActionParticipation.find(params[:id])
  end

  def action_participation_params
    params.require(:action_participation)#.permit(:content, :title)
  end
end
