class Api::V0::PackagesController < ApplicationController
  respond_to :json
  
  def index
    @packages = Package.all
  end
end
