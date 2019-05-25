class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    # @conversations = Conversation.all
    @conversations = policy_scope(Conversation).where('user1_id= ? OR user2_id =?', current_user.id, current_user.id) # current_user, user2: current_user)
    # @user = current_user
    # @conversations = policy_scope(Conversation).where(user1_id: @user.id)
  end

  def create
    if Conversation.between(params[:user1_id], params[:user2_id]).present?
      @conversation = Conversation.between(params[:user1_id], params[:user2_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    authorize @conversation
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def conversation_params
    params.permit(:user1_id, :user2_id)
  end
end
