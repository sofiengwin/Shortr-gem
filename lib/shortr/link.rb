require 'json'
require 'faraday'
require 'byebug'

API_URL = 'http://localhost:3000'.freeze
module Shortr
  class Link
    attr_accessor :token
    attr_reader :status, :response, :connection

    def initialize(token = 0)
      @connection = Faraday.new(url: API_URL)
      @token = token
    end

    def create_shortr_link(full_url, vanity_string = nil)
      params = {
        "link[full_url]" => full_url,
        "link[short_url]" => vanity_string,
        "api_token" => token
      }
      process_response connection.post("/api/links", params)
    end

    def change_short_status(full_url, new_active)
      return false if (new_active.nil? && has_no_token_error)
      params = {
        "link[full_url]" => full_url,
        "link[old]" => get_old_short(full_url),
        "link[active]" => new_active,
        "api_token" => token
      }
      process_response connection.patch("/api/links/ss", params)
    end

    def change_short_target(full_url, new_target)
      return false if (new_target.nil? && has_no_token_error)
      params = {
        "link[full_url]" => full_url,
        "link[old]" => get_old_short(full_url),
        "link[short_url]" => new_target,
        "api_token" => token
      }
      process_response connection.patch("/api/links/ss", params)
    end

    def delete_short(full_url)
      return false if has_no_token_error
      params = {
        "link[full_url]" => full_url,
        "link[old]" => get_old_short(full_url),
        "link[deleted[]]" => true,
        "api_token" => token
      }
      process_response connection.patch("/api/links/ss", params)
    end

    def make_get_request(request)
      process_response(connection.get(request))
    end

    def process_response(response)
      response = JSON.parse(response.body)
      @status = parse_status(response)
      # @response = response['short_url']
   end

    def has_no_token_error
      if !token || token == 0
        @status = { status: 'error', status_info: 'Request requires a valid user token.' }
        return true
      end
      false
    end

    def parse_status(response)
      { type: response['status'], info: response['status_info'] }
   end

   def get_old_short(full_url)
     full_url.split("/").last
   end

  end
end

# puts Shortr::Link.new.create_shortr_link("http://facebook.com", "james")
# token = "lvj5eJA3o-iCtX23pJDg0_slM_AEvFp3EercI761ItffMoKgZ5C50IbI-pGRx13Y"
# puts Shortr::Link.new.change_short_target("http://localhost.com/confirm", "api_token")
