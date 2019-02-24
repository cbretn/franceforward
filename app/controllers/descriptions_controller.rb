class DescriptionsController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @description = Theme.find(params[:theme_id]).description
  end
end
