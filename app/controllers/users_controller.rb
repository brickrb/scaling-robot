class UsersController < ApplicationController
  before_action :set_cache_control_headers, only: [:show]

  def show
    @user = User.find_by(username: params[:username])
    set_surrogate_key_header @user.record_key
  end
end
