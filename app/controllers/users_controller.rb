#encoding: utf-8
class UsersController < ApplicationController

  def living
    render :json => {:success => true}
  end

  def index
    render json: {
        :online_users => @@online_users,
        :anonymous_users => @@anonymous_users
    }
  end
end
