class ActionParticipationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

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
    redirect_to action_participations_path(@action)
  end

  def destroy
    authorize @action_participation
    @action_participation = ActionParticipation.find(params[:id])
    @action = @action_participation.action
    @action_participation.destroy
    redirect_to theme_path(@action)
  end
end
