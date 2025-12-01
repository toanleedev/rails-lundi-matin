# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_client, only: %i[show edit update]

  def index
    @clients = []

    service = ClientService.new(session[:auth_token])
    result = service.search(
      fields: "nom,adresse,ville,tel",
      nom: params[:nom],
      ville: params[:ville],
      limit: params[:limit] || 50
    )

    if result[:success]
      @clients = result[:data].is_a?(Array) ? result[:data] : [result[:data]].compact
    else
      flash.now[:alert] = result[:error]
    end
  end

  def show
    return unless @client.nil?

    redirect_to clients_path, alert: 'Client not found'
  end

  def edit
    return unless @client.nil?

    redirect_to clients_path, alert: 'Client not found'
  end

  def update
    service = ClientService.new(session[:auth_token])
    result = service.update(params[:id], client_params)

    if result[:success]
      flash[:notice] = 'Client updated successfully'
      redirect_to client_path(params[:id])
    else
      flash.now[:alert] = result[:error]
      render :edit
    end
  end

  private

  def set_client
    service = ClientService.new(session[:auth_token])
    result = service.find(params[:id])
    @client = result[:data] if result[:success]
  end

  def client_params
    params.require(:client).permit(:nom, :email, :tel, :ville, :adresse, :code_postal)
  end

  def authenticate_user!
    return if session[:auth_token].present?

    redirect_to login_path, alert: 'Please log in first'
  end
end
