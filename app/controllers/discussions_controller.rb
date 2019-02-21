class DiscussionsController < ApplicationController
  def index
    @theme = Theme.find(params[:theme_id])
    @discussions = policy_scope(Discussion).where(theme: @theme)
  end

  def new

  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
