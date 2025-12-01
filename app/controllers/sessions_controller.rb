# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    result = AuthService.authenticate(params[:username], params[:password])

    if result[:success]
      session[:auth_token] = result[:token]

      redirect_to clients_path, notice: 'Logged in successfully'
    else
      flash.now[:alert] = result[:error]
      render :new
    end
  end

  def destroy
    session[:auth_token] = nil
    redirect_to login_path, notice: 'Logged out successfully'
  end
end
