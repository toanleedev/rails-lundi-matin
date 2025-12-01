# frozen_string_literal: true

require 'base64'

class ClientService
  def initialize(token)
    @token = token
  end

  def search(fields: nil, nom: nil, ville: nil, limit: 50)
    params = { limit: limit, fields: fields }
    params[:nom] = nom if nom.present?
    params[:ville] = ville if ville.present?

    response = client.get("#{base_url}/clients", params)

    if response.success?
      parse_response(response)
    else
      { success: false, error: "Search failed: #{response.status}", data: [] }
    end
  rescue StandardError => e
    { success: false, error: "Search error: #{e.message}", data: [] }
  end

  def find(id)
    response = client.get("#{base_url}/clients/#{id}")

    if response.success?
      parse_response(response)
    else
      { success: false, error: "Client not found: #{response.status}", data: nil }
    end
  rescue StandardError => e
    { success: false, error: "Find error: #{e.message}", data: nil }
  end

  def update id, params
    response = client.put("#{base_url}/clients/#{id}") do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = params.to_json
    end

    if response.success?
      parse_response(response)
    else
      { success: false, error: "Update failed: #{response.status}", data: nil }
    end
  rescue StandardError => e
    { success: false, error: "Update error: #{e.message}", data: nil }
  end

  private

  def base_url
    ENV['LUNDI_MATIN_BASE_URL'].presence
  end

  def client
    @client ||= Faraday.new(url: base_url) do |conn|
      conn.headers['Authorization'] = "Basic #{Base64.strict_encode64(":#{@token}")}"
      conn.headers['Accept'] = 'application/api.rest-v1+json'
      conn.headers['Content-Type'] = 'application/json'
      conn.adapter Faraday.default_adapter
    end
  end

  def parse_response(response)
    body = JSON.parse(response.body)
    { success: true, data: body["datas"] }
  rescue JSON::ParserError => e
    { success: false, error: "Invalid JSON response: #{e.message}", data: nil }
  end
end
