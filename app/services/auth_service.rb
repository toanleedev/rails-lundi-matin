# frozen_string_literal: true

class AuthService
  def self.authenticate(username, password)
    new.authenticate(username, password)
  end

  def authenticate username, password
    response = client.post("#{base_url}/auth") do |req|
      req.headers['Accept'] = 'application/api.rest-v1+json'
      req.headers['Content-Type'] = 'application/json'
      req.body = {
        username: username,
        password: password,
        password_type: 0,
        code_application: 'webservice_externe',
        code_version: '1'
      }.to_json
    end

    if response.success?
      parse_response(response)
    else
      { success: false, error: "Authentication failed: #{response.status}" }
    end
  rescue StandardError => e
    { success: false, error: "Authentication error: #{e.message}" }
  end

  private

  def base_url
    ENV['LUNDI_MATIN_BASE_URL'].presence
  end

  def client
    @client ||= Faraday.new do |conn|
      conn.adapter Faraday.default_adapter
    end
  end

  def parse_response response
    body = JSON.parse(response.body)
    token = body['datas']['token']

    if token.present?
      { success: true, token: token }
    else
      { success: false, error: 'No token in response' }
    end
  rescue JSON::ParserError => e
    { success: false, error: "Invalid JSON response: #{e.message}" }
  end
end
