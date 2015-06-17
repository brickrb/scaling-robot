class Api::V0::VersionsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_action :doorkeeper_authorize!
  before_action :set_package
  before_action :valid_ownership
  respond_to :json

  def create
    @version = Version.new(version_params.merge(package_id: @package.id))
    if @version.save
      render json: {}, status: 201
    else
      render json: { "error": "Version could not be saved." }, status: 422
    end
  end

  private

    def set_package
      @package = Package.find_by(name: params[:name])
    end

    def valid_ownership
      @package = Package.find_by(name: params[:name])
      if @package = current_user.packages.find_by(name: params[:name])
      else
        render json: { "error": "Not authorized." }, status: 401
      end
    end

    def version_params
      params.require(:version).permit(:description, :license, :number, :package_id, :shasum)
    end
end
