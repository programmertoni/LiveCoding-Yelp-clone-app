class UiController < ApplicationController
  before_action { redirect_to :root if Rails.env.production? }

  layout 'application'
  def index; end
end
