require 'serubyum/selenium_server'

module Serubyum
  class Session
    attr_accessor :id, :url, :title

    def connect()
      resp = Serubyum::SeleniumServer.post('session', browserName: 'firefox')
      json_body = JSON.parse(resp.body)
      self.id = json_body['sessionId']
      return self
    end

    def go(url)
      resp = Serubyum::SeleniumServer.post("session/#{@id}/url", url: url)
      # if we got here without an exception being raised, the navigation is complete
      self.url = url
      return self
    end

    def fetch_title
      # TODO add some caching: if the url hasn't changed since the last
      # title-get, just return the cached title
      resp = Serubyum::SeleniumServer.get("session/#{@id}/title")
      self.title = resp.body
      return self.title
    end
  end
end