class PackagesController < ApplicationController
  def show
    @package = Package.find_by(name: params[:name])
  end
end
