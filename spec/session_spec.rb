require 'spec_helper'

describe Serubyum::Session do
  session_id = nil
  url = "www.google.com"
  page_title = "Google"

  element_id = "asdfyuoiqwer"
  element_strategy = "css selector"
  google_searchbar_selector = "input#lst-ib.gsfi"

  element_search_hash = {}
  element_search_hash[element_strategy] = google_searchbar_selector

  escaped_element_search_hash = {}
  element_search_hash[element_strategy.gsub(' ', '+')] = google_searchbar_selector

  before(:each) do
    session_id = "1234567890"
    base_url = Serubyum::SeleniumServer::BASE_URL
    sessionResp = "{\"sessionId\":\"#{session_id}\"}"
    elementResp = "{\"ELEMENT\":\"#{element_id}\"}"

    stub_request(:post, base_url + 'session').
        to_return(status: 200, body: sessionResp, headers: { 'Content-Length' => sessionResp.length, 'Content-Type': 'application/json' })

    stub_request(:post, base_url + "session/#{session_id}/url").
        with(body: {url: url}).
        to_return(status: 200, body: sessionResp, headers: { 'Content-Length' => sessionResp.length, 'Content-Type': 'application/json' })

    stub_request(:get, base_url + "session/#{session_id}/title").
        to_return(status: 200, body: page_title, headers: { 'Content-Length' => sessionResp.length, 'Content-Type': 'application/json' })

    stub_request(:post, base_url + "session/#{session_id}/element").
        with(body: escaped_element_search_hash).
        to_return(status: 200, body: elementResp, headers: { 'Content-Length' => sessionResp.length, 'Content-Type': 'application/json' })
  end

  describe '#connect' do
    it 'should open a browser' do
      session = Serubyum::Session.new.connect

      expect(session).to be_a(Serubyum::Session)
      expect(session.id.to_s).to eq(session_id.to_s)
    end
  end

  describe '#go' do
    it 'should navigate to a page' do
      session = Serubyum::Session.new(session_id)

      session.go(url)

      expect(session.url).to eq(url)
    end
  end

  describe '#fetch_title' do
    it 'should return the title of the current page' do
      session = Serubyum::Session.new(session_id, url)

      title = session.fetch_title

      expect(title).to eq(page_title)
      expect(session.title).to eq(page_title)
    end
  end

  describe "#element_by" do
    it 'should return a new elment with the proper id' do
      session = Serubyum::Session.new(session_id, url)

      element = session.element_by(element_search_hash)
      expect(element).to be_a(Serubyum::Element)
      expect(element.id).to eq(element_id)
    end
  end
end
