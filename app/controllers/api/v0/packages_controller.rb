class Api::V0::PackagesController < ApplicationController
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
end
