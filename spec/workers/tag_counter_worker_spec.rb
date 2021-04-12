require 'rails_helper'
describe TagCounterWorker, type: :worker do
  let!(:tag_1) { create(:tag, title: 1, tickets_count: 1)}
  let!(:tag_2) { create(:tag, title: 2, tickets_count: 2)}
  let!(:tag_3) { create(:tag, title: 3, tickets_count: 3)}

  before do
    stub_request(:post, "http://webhook.site:443/526c9190-3486-406b-8ae3-ebec4121adb1").
         with(
           body: "{\"tag\":\"3\",\"mentions\":3}",
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Host'=>'webhook.site',
          'User-Agent'=>'Ruby'
           }).
         to_return(status: 200, body: "", headers: {})
    TagCounterWorker.new.perform
  end

  it 'makes a request to webhook site reporting the correct tag' do
    expect(a_request(:post, "http://webhook.site:443/526c9190-3486-406b-8ae3-ebec4121adb1").with(body: '{"tag":"3","mentions":3}', headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'webhook.site', 'User-Agent'=>'Ruby'})).to have_been_made.once
  end
end
