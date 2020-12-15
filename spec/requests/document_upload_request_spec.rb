require 'rails_helper'

RSpec.describe "DocumentUploads", type: :request do
  let(:pdf_file) { fixture_file_upload('test_pdf.pdf', 'text/pdf') }

  # Test suite for POST /document-upload
  describe 'POST /document-upload' do
    let(:client) { create(:client, source_app: 'evidence_locker') }

    let(:headers) {{
      "ACCEPT" => "application/json",
      "HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials(client.source_app, client.api_key)
    }}

    context 'when success' do
      context 'when posting a file' do
        let(:valid_attributes) { { document_file: pdf_file, service_name: 'evidence_locker', type_validation: ['pdf'], size_validation: 1000000 } }

        it 'creates a Document' do
          expect{ post '/document-upload', params: valid_attributes, headers: headers }.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect{ post '/document-upload', params: valid_attributes, headers: headers }.to change(UncheckedDocument, :count).by(1)
        end

        it 'returns status code 201' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is csv' do
        let(:csv_file) { fixture_file_upload('test_csv.csv', 'text/csv') }
        let(:valid_attributes) { { document_file: csv_file, service_name: 'evidence_locker', type_validation: ['csv'], size_validation: 1000000 } }

        it 'creates a Document' do
          expect{ post '/document-upload', params: valid_attributes, headers: headers }.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect{ post '/document-upload', params: valid_attributes, headers: headers }.to change(UncheckedDocument, :count).by(1)
        end

        it 'returns status code 201' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is xlsx' do
        let(:xlsx_file) { fixture_file_upload('test_xlsx.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') }
        let(:valid_attributes) { { document_file: xlsx_file, service_name: 'evidence_locker', type_validation: ['spreadsheet'], size_validation: 1000000 } }

        it 'creates a Document' do
          expect{ post '/document-upload', params: valid_attributes, headers: headers }.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect{ post '/document-upload', params: valid_attributes, headers: headers }.to change(UncheckedDocument, :count).by(1)
        end

        it 'returns status code 201' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is docx' do
        let(:docx_file) { fixture_file_upload('test_docx.docx', 'text/docx') }
        let(:valid_attributes) { { document_file: docx_file, service_name: 'evidence_locker', type_validation: ['docx'], size_validation: 1000000 } }

        it 'creates a Document' do
          expect{ post '/document-upload', params: valid_attributes, headers: headers }.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect{ post '/document-upload', params: valid_attributes, headers: headers }.to change(UncheckedDocument, :count).by(1)
        end

        it 'returns status code 201' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when posting a document_file_path' do
        let(:file_path) { "https://www.example.com/test_pdf.pdf" }
        let(:valid_attributes) { { document_file_path: file_path, service_name: 'evidence_locker', type_validation: ['octet-stream'], size_validation: 1000000 } }

        before do
          stub_request(:get, "https://www.example.com/test_pdf.pdf").
            with(
              headers: {
                'Accept'=>'*/*',
                'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'User-Agent'=>'CarrierWave/2.1.0'
              }).
            to_return(status: 200, body: File.open(pdf_file), headers: {})
        end

        it 'creates a Document' do
          expect{ post '/document-upload', params: valid_attributes, headers: headers }.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect{ post '/document-upload', params: valid_attributes, headers: headers }.to change(UncheckedDocument, :count).by(1)
        end

        it 'returns status code 201' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end
    end

    context 'when document_file and document_file_path parameters are missing' do
      let(:invalid_attributes) { { service_name: 'evidence_locker', type_validation: ['pdf'], size_validation: 1000000  } }

      it 'does not create a Document' do
        expect{ post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect{ post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(UncheckedDocument, :count)
      end

      it 'returns status code 422' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response.body).to include(I18n.t('unchecked_document.base.no_file'))
      end
    end

    context 'when type validation fails' do
      let(:invalid_attributes) { { document_file: pdf_file, service_name: 'evidence_locker', type_validation: %w[csv docx], size_validation: 1000000  } }

      it 'does not create a Document' do
        expect{ post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect{ post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(UncheckedDocument, :count)
      end

      it 'returns status code 422' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response.body).to include(I18n.t('unchecked_document.base.wrong_format'))
      end

    end

    context 'when size validation fails' do
      let(:invalid_attributes) { { document_file: pdf_file, service_name: 'evidence_locker', type_validation: ['pdf'], size_validation: 2000  } }

      it 'does not create a Document' do
        expect{ post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect{ post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(UncheckedDocument, :count)
      end

      it 'returns status code 422' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response.body).to include(I18n.t('unchecked_document.base.file_too_big'))
      end
    end

    context 'when size validation is larger than 5gb' do
      let(:invalid_attributes) { { document_file: pdf_file, service_name: 'evidence_locker', type_validation: ['pdf'], size_validation: UncheckedDocument::FIVE_GIGABITES_IN_BYTES + 1  } }

      it 'does not create a Document' do
        expect{ post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect{ post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(UncheckedDocument, :count)
      end

      it 'returns status code 422' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response.body).to include(I18n.t('unchecked_document.base.max_file_size'))
      end
    end

    context 'when unauthorized' do
      let(:headers) {{
        "ACCEPT" => "application/json",
        "HTTP_AUTHORIZATION" => ActionController::HttpAuthentication::Basic.encode_credentials('test', 'test')
      }}

      context 'when posting a file' do
        let(:valid_attributes) { { document_file: pdf_file, service_name: 'evidence_locker', type_validation: ['pdf'], size_validation: 1000000 } }

        it 'creates a Document' do
          expect{ post '/document-upload', params: valid_attributes, headers: headers }.to change(Document, :count).by(0)
        end

        it 'creates an UncheckedDocument' do
          expect{ post '/document-upload', params: valid_attributes, headers: headers }.to change(UncheckedDocument, :count).by(0)
        end

        it 'returns status code 201' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(response).to have_http_status(401)
        end
      end
    end
  end

end
