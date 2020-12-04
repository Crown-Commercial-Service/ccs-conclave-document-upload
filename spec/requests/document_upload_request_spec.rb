require 'rails_helper'

RSpec.describe "DocumentUploads", type: :request do
  let(:pdf_file) { fixture_file_upload('test_pdf.pdf', 'text/pdf') }

  # Test suite for POST /document-upload
  describe 'POST /document-upload' do
    context 'when success' do
      context 'when posting a file' do
        let(:valid_attributes) { { document_file: pdf_file, service_name: 'evidence_locker', type_validation: ['pdf'], size_validation: '10mb' } }

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

      context 'when posting a document_file_path' do
        let(:valid_attributes) { { document_file_path: pdf_file.path, service_name: 'evidence_locker', type_validation: ['pdf'], size_validation: '10mb' } }

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

    context 'when document_file and document_file_path parameters are missing' do
      let(:invalid_attributes) { { service_name: 'evidence_locker', type_validation: ['pdf'], size_validation: '10mb'  } }

      it 'does not create a Document' do
        expect{ post '/document-upload', params: invalid_attributes }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect{ post '/document-upload', params: invalid_attributes }.to_not change(UncheckedDocument, :count)
      end

      it 'returns status code 422' do
        post '/document-upload', params: invalid_attributes
        expect(response).to have_http_status(422)
      end
    end

    context 'when type validation fails' do
      let(:invalid_attributes) { { document_file: pdf_file, service_name: 'evidence_locker', type_validation: %w[csv docx], size_validation: '10mb'  } }

      it 'does not create a Document' do
        expect{ post '/document-upload', params: invalid_attributes }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect{ post '/document-upload', params: invalid_attributes }.to_not change(UncheckedDocument, :count)
      end

      it 'returns status code 422' do
        post '/document-upload', params: invalid_attributes
        expect(response).to have_http_status(422)
      end
    end

    context 'when size validation fails' do
      let(:invalid_attributes) { { document_file: pdf_file, service_name: 'evidence_locker', type_validation: ['pdf'], size_validation: '20kb'  } }

      it 'does not create a Document' do
        expect{ post '/document-upload', params: invalid_attributes }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect{ post '/document-upload', params: invalid_attributes }.to_not change(UncheckedDocument, :count)
      end

      it 'returns status code 422' do
        post '/document-upload', params: invalid_attributes
        expect(response).to have_http_status(422)
      end
    end

    # context 'when unauthorized' do
    #   before { post '/document-upload' }
    #
    #   it 'returns Document' do
    #     expect(document).to_be be_empty
    #   end
    #
    #   it 'returns status code 01' do
    #     expect(response).to have_http_status(401)
    #   end
    # end
  end

end
