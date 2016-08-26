require 'spec_helper'

describe Serubyum::Session do
  session_id = nil
  url = "www.google.com"
  page_title = "Google"

  before(:each) do
    session_id = "1234567890"
    base_url = Serubyum::SeleniumServer::BASE_URL
    sessionResp = "{\"sessionId\":\"#{session_id}\"}"

    stub_request(:post, base_url + 'session').
        to_return(status: 200, body: sessionResp, headers: { 'Content-Length' => sessionResp.length, 'Content-Type': 'application/json' })

    stub_request(:post, base_url + "session/#{session_id}/url").
        with(body: {url: url}).
        to_return(status: 200, body: sessionResp, headers: { 'Content-Length' => sessionResp.length, 'Content-Type': 'application/json' })

    stub_request(:get, base_url + "session/#{session_id}/title").
        to_return(status: 200, body: page_title, headers: { 'Content-Length' => sessionResp.length, 'Content-Type': 'application/json' })
  end

  describe '#connect' do
    it 'opens a browser' do
      session = Serubyum::Session.new.connect

      expect(session).to be_a(Serubyum::Session)
      expect(session.id.to_s).to eq(session_id.to_s)
    end
  end

  describe '#go' do
    it 'navigates to a page' do
      session = Serubyum::Session.new
      session.id = session_id
      session.go(url)

      expect(session.url).to eq(url)
    end
  end

  describe '#title' do
    it 'returns the title of the current page' do
      session = Serubyum::Session.new
      session.id = session_id
      session.url = url
      title = session.fetch_title

      expect(title).to eq(page_title)
      expect(session.title).to eq(page_title)
    end
  end
end
