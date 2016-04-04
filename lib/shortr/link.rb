require "json"
require "faraday"
require "byebug"
require "pry"

API_URL = "http://shotr.herokuapp.com/".freeze
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
        "link[api_key]" => token
      }
      process_response connection.post("/api/links", params)
    end

    def change_short_status(full_url, new_active)
      return false if new_active.nil? && has_no_token_error
      params = {
        "link[full_url]" => full_url,
        "link[old]" => get_old_short(full_url),
        "link[active]" => new_active,
        "link[api_key]" => token
      }
      process_response connection.patch("/api/links/ss", params)
    end

    def change_short_target(full_url, new_target)
      return false if new_target.nil? && has_no_token_error
      params = {
        "link[full_url]" => full_url,
        "link[old]" => get_old_short(full_url),
        "link[short_url]" => new_target,
        "link[api_key]" => token
      }
      process_response connection.patch("/api/links/ss", params)
    end

    def delete_short(full_url)
      return false if has_no_token_error
      params = {
        "link[full_url]" => full_url,
        "link[old]" => get_old_short(full_url),
        "link[deleted[]]" => true,
        "link[api_key]" => token
      }
      process_response connection.patch("/api/links/ss", params)
    end

    # def make_get_request(request)
    #   process_response(connection.get(request))
    # end

    def process_response(response)
      response = JSON.parse(response.body)
      @status = parse_status(response)
     # @response = response['short_url']
   end

    def has_no_token_error
      if !token || token == 0
        @status = { status: "error", status_info: "Request requires a valid user token." }
        return true
      end
      false
    end

    def parse_status(response)
      { status: response["status"], status_info: response["status_info"], short_url: response["short_url"] }
   end

    def get_old_short(full_url)
      full_url.split("/").last
    end
  end
end
# token = "lvj5eJA3o-iCtX23pJDg0_slM_AEvFp3EercI761ItffMoKgZ5C50IbI-pGRx13Y"
# puts Shortr::Link.new(token).create_shortr_link("http://facebook.com", "fbtest2")
# puts Shortr::Link.new(token).change_short_target("http://shotr.herokuapp.com/fbtest", "fbtest2")
