require 'spec_helper'

describe Serubyum do
  it 'has a version number' do
    expect(Serubyum::VERSION).not_to be nil
  end

  it 'should get a connected session' do
    session_id = "1234567890"
    base_url = Serubyum::SeleniumServer::BASE_URL
    sessionResp = "{\"sessionId\":\"#{session_id}\"}"

    stub_request(:post, base_url + 'session').
        to_return(status: 200, body: sessionResp, headers: { 'Content-Length' => sessionResp.length, 'Content-Type': 'application/json' })

    session = Serubyum.new_session

    expect(session).to be_a(Serubyum::Session)
    expect(session.id.to_s).to eq(session_id.to_s)
  end
end
