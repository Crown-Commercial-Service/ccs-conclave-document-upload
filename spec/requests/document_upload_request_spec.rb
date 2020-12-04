require 'rails_helper'

RSpec.describe "DocumentUploads", type: :request do
  let(:pdf_file) { fixture_file_upload('test_pdf.pdf', 'text/pdf') }

  # Test suite for POST /document-upload
  describe 'POST /document-upload' do
    context 'when success' do
      context 'when posting a file' do
        let(:valid_attributes) { { file: pdf_file, service_name: 'evidence_locker', validations: { type: ['pdf'], size: '10mb'  } } }

        it 'creates a Document' do
          expect{ post '/document-upload', params: valid_attributes }.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect{ post '/document-upload', params: valid_attributes }.to change(UncheckedDocument, :count).by(1)
        end

        it 'returns status code 201' do
          post '/document-upload', params: valid_attributes
          expect(response).to have_http_status(201)
        end
      end

      context 'when posting a file_path' do
        let(:valid_attributes) { { file_path: pdf_file.path, service_name: 'evidence_locker', validations: { type: ['pdf'], size: '10mb' } } }

        it 'creates a Document' do
          expect{ post '/document-upload', params: valid_attributes }.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect{ post '/document-upload', params: valid_attributes }.to change(UncheckedDocument, :count).by(1)
        end

        it 'returns status code 201' do
          post '/document-upload', params: valid_attributes
          expect(response).to have_http_status(201)
        end
      end
    end

    context 'when file parameter is missing' do
      before { post '/document-upload', params: { service_name: 'evidence_locker', validations: { type: ['pdf'], size: '10mb'  } } }

      it 'does not create a Document' do
        expect{ post '/document-upload', params: valid_attributes }.to change(Document, :count).by(0)
      end

      it 'does not create a UncheckedDocument' do
        expect{ post '/document-upload', params: valid_attributes }.to change(UncheckedDocument, :count).by(0)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when file_path parameter is missing' do
      before { post '/document-upload' }

      it 'returns Document' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when type validation fails' do
      before { post '/document-upload' }

      it 'returns Document' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when size validation fails' do
      before { post '/document-upload' }

      it 'returns Document' do
        expect(json).not_to be_empty
        expect(json.size).to eq(10)
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when unauthorized' do
      before { post '/document-upload' }

      it 'returns Document' do
        expect(document).to_be be_empty
      end

      it 'returns status code 01' do
        expect(response).to have_http_status(401)
      end
    end
  end

end
