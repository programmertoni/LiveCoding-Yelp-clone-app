class FlagsController < ApplicationController
  before_action :require_admin, only: [:index, :destroy]
  before_action :require_user

  def index
    @flags = Flag.all
  end

  def create
    @review_id = params[:review_id]
    Flag.create(flaged: true,
                review_id: @review_id,
                flaged_user_id: params[:flaged_user_id],
                flaged_by_user_id: params[:flaged_by_user_id])

    respond_to do |format|
      format.js
    end
  end

  def destroy
    Flag.find(params[:id]).destroy
    redirect_to flags_path
  end

end
