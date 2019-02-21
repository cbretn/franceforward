class DescriptionController < ApplicationController
  def show
    @description = Description.find(params[:id])
  end
end
