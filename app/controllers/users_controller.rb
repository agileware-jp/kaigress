# frozen_string_literal: true

class UsersController < ApplicationController
  def new
  end

  def show
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to root_path
    else
      # TODO
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname)
  end
end
