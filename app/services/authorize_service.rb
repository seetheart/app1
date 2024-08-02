require 'net/http'

class AuthorizeService
  def initialize(params)
    @params = params
  end

  def authorize
    uri = URI('http://127.0.0.1:3000')
    uri.path = '/api/v1/authorize'
    req = Net::HTTP::Post.new(uri)
    req.body = @params.to_json
    req['Authorization'] = ENV['AUTH_API_KEY']
    req.content_type = 'application/json'
    res = Net::HTTP.start(uri.hostname, 3000) do |http|
      http.request(req)
    end
    parsed_response = JSON.parse(res.body).to_h
    return false if parsed_response["authorized"] == false

    true
  end
end
