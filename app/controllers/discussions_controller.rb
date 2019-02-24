class DiscussionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_discussion, only: [:show, :edit, :update]

  def index
    @theme = Theme.find(params[:theme_id])
    @discussions = policy_scope(Discussion).where(theme: @theme)
  end

  def new
    @discussion = Discussion.new
    @theme = Theme.find(params[:theme_id])
    authorize @discussion
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @theme = Theme.find(params[:theme_id])
    @discussion.theme = @theme
    @discussion.user = current_user
    authorize @discussion
    if @discussion.save!
      redirect_to category_theme_discussion_path(@theme.category, @theme, @discussion)
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    authorize @discussion
    if @discussion.update(discussion_params)
      redirect_to discussion_path(@discussion)
    else
      render :edit
    end
  end

  def destroy
    authorize @discussion
    @discussion = Discussion.find(params[:id])
    # @theme = @discussion.theme
    @discussion.destroy
    redirect_to theme_path(@theme)
  end

  private

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end

  def discussion_params
    params.require(:discussion).permit(:content, :title)
  end
end
