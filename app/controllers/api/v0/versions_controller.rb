class Api::V0::VersionsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_action :doorkeeper_authorize!
  respond_to :json

  def create
  end

  private
end
