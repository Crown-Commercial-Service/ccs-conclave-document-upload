require 'rails_helper'

RSpec.describe CallCheckServiceWorker do
  let(:unchecked_document) do
    create(:unchecked_document,
           document_file: Rack::Test::UploadedFile.new('spec/fixtures/test_pdf.pdf', 'text/pdf'),
           type_validation: ['pdf'],
           size_validation: 1000000)
  end
  let(:put_response) { instance_double(HTTParty::Response, body: put_response_body) }
  let(:put_response_body) { 'response_body' }
  let(:request_url) { "#{ENV['CHECK_ENDPOINT_URL']}/#{unchecked_document.document_id}" }
  let(:headers) { { 'x-api-key' => ENV['AUTH_TOKEN'] } }

  before do
    allow(HTTParty).to receive(:put).and_return(put_response)

    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with('CHECK_ENDPOINT_URL').and_return('https://api.example.com')
    allow(ENV).to receive(:[]).with('AUTH_TOKEN').and_return('secret_token')
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
      allow(ENV).to receive(:[]).with('CHECK_ENDPOINT_URL').and_return(nil)
      CallCheckServiceWorker.new.perform(unchecked_document.id)
      expect(HTTParty).to_not have_received(:put)
    end
  end
end
