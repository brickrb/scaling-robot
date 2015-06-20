class Api::V0::VersionsController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_action :doorkeeper_authorize!
  before_action :set_package
  before_action :valid_ownership
  respond_to :json

  def create
    #if @package.versions.where(number: version_params[:number]).any?
    if Version.exists?(package_id: @package.id, number: version_params[:number])
      render json: { "error": "Version could not be saved, a version with this number already exists." }, status: 422
      false
    else
      @version = Version.new(version_params.merge(package_id: @package.id))
      if @version.save
        VersionTweeterJob.enqueue(@version.id)
        render json: {}, status: 201
      else
        render json: { "error": "Version could not be saved." }, status: 422
      end
    end
  end

  def destroy
    @version = Version.joins(:package).where(packages: {name: params[:name]}).find_by(number: params[:number])
    if @version.destroy
      render json: {}, status: 204
    else
      render json: { "error": "Version could not be deleted." }, status: 422
    end
  end

  private

    def set_package
      @package = Package.find_by(name: params[:name])
    end

    def valid_ownership
      @package = Package.find_by(name: params[:name])
      if Ownership.where(package_id: @package.id, user_id: current_api_user.id).any?
      else
        render json: { "error": "Not authorized.", "user": "#{current_api_user.email}" }, status: 401
      end
    end

    def version_params
      params.require(:version).permit(:description, :license, :number, :package_id, :shasum)
    end
end
