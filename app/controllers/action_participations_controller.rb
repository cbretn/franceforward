class ActionParticipationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_participation, only: [:destroy]

  def index
    @action = Action.find(params[:action_id])
    @action_participations = policy_scope(ActionParticipation).where(action: @action)
  end

  def create
    @action_participation = ActionParticipation.new(user: current_user)
    @action = Action.find(params[:action_id])
    @action_participation.action = @action
    @action_participation.user = current_user
    authorize @action_participation
    @action_participation.save!
    redirect_to category_theme_action_path(@action.theme.category.id, @action.theme.id, @action.id)
  end

  def destroy
    authorize @action_participation
    @action_participation = ActionParticipation.find(params[:id])
    @action = @action_participation.action
    @action_participation.destroy
    redirect_to category_theme_action_path(@action.theme.category, @action.theme, @action)
  end

  private

  def set_participation
    @action_participation = ActionParticipation.find(params[:id])
  end
end
