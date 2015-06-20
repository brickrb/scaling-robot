class Api::V0::PackagesController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  before_action :doorkeeper_authorize!
  before_action :set_package, only: [:show, :destroy]
  respond_to :json

  def index
    @packages = Package.all
  end

  def show
    if @package
      @versions = @package.versions.all if @package.versions.any?
    else
      render json: { "error": "Package could not be found." }, status: 404
    end
  end

  def create
    @package = Package.new(package_params)
    if @package.save

      @ownership = Ownership.create!(package_id: @package.id, user_id: current_api_user.id)
      if @ownership.save
        render :show, status: 201
      else
        render json: { "error": "Package could not be saved." }, status: 422
      end

    else
      render json: { "error": "Package could not be saved." }, status: 422
    end
  end

  def destroy
    @ownerships = Ownership.where(package_id: @package.id).all
    if @package.destroy && @ownerships.destroy_all
      render json: {}, status: 204
    else
      render json: { "error": "Package could not be deleted." }, status: 422
    end
  end

  private
    def set_package
      @package = Package.find_by(name: params[:name])
    end

    def package_params
      params.require(:package).permit(:name)
    end
end
