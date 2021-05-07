require 'rails_helper'

RSpec.describe CallCheckServiceWorker do
  let(:unchecked_document) do
    create(:unchecked_document,
           document_file: fixture_file_upload('test_pdf.pdf', 'text/pdf'),
           type_validation: ['pdf'],
           size_validation: 1000000)
  end
  let(:put_response) { instance_double(HTTParty::Response, body: put_response_body) }
  let(:put_response_body) { 'response_body' }
  let(:request_url) { "#{ENV['CHECK_ENDPOINT_URL']}/#{unchecked_document.document_id}" }
  let(:headers) { { 'x-api-key' => ENV['AUTH_TOKEN'] } }

  before do
    allow(HTTParty).to receive(:put).and_return(put_response)
  end

  it { is_expected.to be_processed_in :upload }
  it { is_expected.to be_retryable 5 }

  context 'when CHECK_ENDPOINT_URL is present' do
    it 'calls the put request' do
      CallCheckServiceWorker.new.perform(unchecked_document.id)
      expect(HTTParty).to have_received(:put).with(request_url, headers: headers)
    end
  end

  context 'when CHECK_ENDPOINT_URL is not present' do
    it 'does not call the put request' do
      ENV['CHECK_ENDPOINT_URL'] = nil
      CallCheckServiceWorker.new.perform(unchecked_document.id)
      expect(HTTParty).to_not have_received(:put).with(request_url, headers: headers)
    end
  end
end
