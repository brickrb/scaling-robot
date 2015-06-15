class Api::V0::PackagesController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }
  respond_to :json

  def index
    @packages = Package.all
  end

  def show
    if @package = Package.find_by(name: params[:name])
    else
      render json: { "error": "Package could not be found." }, status: 404
    end
  end

  def create
    @package = Package.new(package_params)
    if @package.save
      render :show, status: 201
    else
      render json: { "error": "Package could not be saved." }, status: 422
    end
  end

  private
    def package_params
      params.require(:package).permit(:name)
    end
end
