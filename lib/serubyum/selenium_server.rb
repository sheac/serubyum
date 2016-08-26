require 'net/http'

module Serubyum
  module SeleniumServer
    BASE_URL = 'http://localhost:4444/wd/hub/'

    def self.post(path, data)
      uri = URI(BASE_URL + path)
      resp = Net::HTTP.post_form(uri, data)
      if resp.code != "200"
        raise "Selenium Service Error: #{resp.body}"
      end
      return resp
    end

    def self.get(path)
      uri = URI(BASE_URL + path)
      resp = Net::HTTP.get_response(uri)
      if resp.code != "200"
        raise "Selenium Service Error: #{resp.body}"
      end
      return resp
    end
  end
end
