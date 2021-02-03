require 'rails_helper'

RSpec.describe 'DocumentUploads', type: :request do
  let(:pdf_file) { fixture_file_upload('test_pdf.pdf', 'text/pdf') }

  # Test suite for POST /document-upload
  describe 'POST /document-upload' do
    let(:client) { create(:client, source_app: 'evidence_locker') }
    let(:put_response) { instance_double(HTTParty::Response, body: put_response_body) }
    let(:put_response_body) { 'response_body' }

    let(:headers) do
      {
        'ACCEPT' => 'application/json',
        'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(client.source_app,
                                                                                               client.api_key)
      }
    end

    before do
      allow(HTTParty).to receive(:put).and_return(put_response)
    end

    context 'when success' do
      context 'when posting a file' do
        let(:valid_attributes) { { document_file: pdf_file, type_validation: ['pdf'], size_validation: 1000000 } }

        it 'creates a Document' do
          expect do
            post '/document-upload', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/document-upload', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'does the PUT request' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(HTTParty).to have_received(:put).with(ENV['CHECK_ENDPOINT_URL'], body:
            { unchecked_document_id: UncheckedDocument.last.id }, headers: { 'Authorization' => ENV['AUTH_TOKEN'] })
        end

        it 'returns status code 201' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is csv' do
        let(:csv_file) { fixture_file_upload('test_csv.csv', 'text/csv') }
        let(:valid_attributes) { { document_file: csv_file, type_validation: ['csv'], size_validation: 1000000 } }

        it 'creates a Document' do
          expect do
            post '/document-upload', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/document-upload', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'does the PUT request' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(HTTParty).to have_received(:put).with(ENV['CHECK_ENDPOINT_URL'], body:
            { unchecked_document_id: UncheckedDocument.last.id }, headers: { 'Authorization' => ENV['AUTH_TOKEN'] })
        end

        it 'returns status code 201' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is xlsx' do
        let(:xlsx_file) do
          fixture_file_upload('test_xlsx.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        end
        let(:valid_attributes) do
          { document_file: xlsx_file, type_validation: ['spreadsheet'], size_validation: 1000000 }
        end

        it 'creates a Document' do
          expect do
            post '/document-upload', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/document-upload', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'does the PUT request' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(HTTParty).to have_received(:put).with(ENV['CHECK_ENDPOINT_URL'], body:
            { unchecked_document_id: UncheckedDocument.last.id }, headers: { 'Authorization' => ENV['AUTH_TOKEN'] })
        end

        it 'returns status code 201' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is docx' do
        let(:docx_file) { fixture_file_upload('test_docx.docx', 'text/docx') }
        let(:valid_attributes) { { document_file: docx_file, type_validation: ['docx'], size_validation: 1000000 } }

        it 'creates a Document' do
          expect do
            post '/document-upload', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/document-upload', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'does the PUT request' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(HTTParty).to have_received(:put).with(ENV['CHECK_ENDPOINT_URL'], body:
            { unchecked_document_id: UncheckedDocument.last.id }, headers: { 'Authorization' => ENV['AUTH_TOKEN'] })
        end

        it 'returns status code 201' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when posting a document_file_path' do
        let(:file_path) { 'https://www.example.com/test_pdf.pdf' }
        let(:valid_attributes) do
          { document_file_path: file_path, type_validation: ['octet-stream'], size_validation: 1000000 }
        end

        before do
          stub_request(:get, 'https://www.example.com/test_pdf.pdf')
            .with(
              headers: {
                'Accept' => '*/*',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'User-Agent' => 'CarrierWave/2.1.0'
              }
            )
            .to_return(status: 200, body: File.open(pdf_file), headers: {})
        end

        it 'creates a Document' do
          expect do
            post '/document-upload', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/document-upload', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'does the PUT request' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(HTTParty).to have_received(:put).with(ENV['CHECK_ENDPOINT_URL'], body:
            { unchecked_document_id: UncheckedDocument.last.id }, headers: { 'Authorization' => ENV['AUTH_TOKEN'] })
        end

        it 'returns status code 201' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when posting a file and document_file_path is blank' do
        let(:valid_attributes) do
          { document_file_path: '', document_file: pdf_file, type_validation: ['pdf'], size_validation: 1000000 }
        end

        it 'creates a Document' do
          expect do
            post '/document-upload', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/document-upload', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'does the PUT request' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(HTTParty).to have_received(:put).with(ENV['CHECK_ENDPOINT_URL'], body:
            { unchecked_document_id: UncheckedDocument.last.id }, headers: { 'Authorization' => ENV['AUTH_TOKEN'] })
        end

        it 'returns status code 201' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end
    end

    context 'when document_file_path is missing protocol' do
      let(:file_path) { 'www.example.com/test_pdf.pdf' }
      let(:valid_attributes) do
        { document_file_path: file_path, service_name: 'evidence_locker', type_validation: ['octet-stream'],
          size_validation: 1000000 }
      end

      before do
        stub_request(:get, 'http://www.example.com/test_pdf.pdf')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'CarrierWave/2.1.0'
            }
          )
          .to_return(status: 200, body: File.open(pdf_file), headers: {})
      end

      it 'creates a Document' do
        expect { post '/document-upload', params: valid_attributes, headers: headers }.to change(Document, :count).by(1)
      end

      it 'creates an UncheckedDocument' do
        expect do
          post '/document-upload', params: valid_attributes, headers: headers
        end.to change(UncheckedDocument, :count).by(1)
      end

      it 'does the PUT request' do
        post '/document-upload', params: valid_attributes, headers: headers
        expect(HTTParty).to have_received(:put).with(ENV['CHECK_ENDPOINT_URL'], body:
          { unchecked_document_id: UncheckedDocument.last.id }, headers: { 'Authorization' => ENV['AUTH_TOKEN'] })
      end

      it 'returns status code 201' do
        post '/document-upload', params: valid_attributes, headers: headers
        expect(response).to have_http_status(201)
      end
    end

    context 'when document_file and document_file_path parameters are missing' do
      let(:invalid_attributes) { { type_validation: ['pdf'], size_validation: 1000000 } }

      it 'does not create a Document' do
        expect { post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/document-upload', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not do the PUT request' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(HTTParty).not_to have_received(:put)
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
      let(:invalid_attributes) { { document_file: pdf_file, type_validation: %w[csv docx], size_validation: 1000000 } }

      it 'does not create a Document' do
        expect { post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/document-upload', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not do the PUT request' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(HTTParty).not_to have_received(:put)
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

    context 'when file unsupported type' do
      let(:xls_file) { fixture_file_upload('test_xls.xls', 'application/vnd.ms-excel') }
      let(:invalid_attributes) do
        { document_file_path: '', document_file: xls_file, type_validation: ['xls'], size_validation: 1000000 }
      end

      it 'does not create a Document' do
        expect { post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/document-upload', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not do the PUT request' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(HTTParty).not_to have_received(:put)
      end

      it 'returns status code 422' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response.body).to include('You are not allowed to upload') 
      end
    end

    context 'when file path unsupported type' do
      let(:xls_file) { fixture_file_upload('test_xls.xls', 'application/vnd.ms-excel') }
      let(:file_path) { 'https://www.example.com/test_xls.xls' }
      let(:invalid_attributes) do
        { document_file_path: file_path, type_validation: ['xls'], size_validation: 1000000 }
      end

      before do
        stub_request(:get, 'https://www.example.com/test_xls.xls')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'User-Agent' => 'CarrierWave/2.1.0'
            }
          )
          .to_return(status: 200, body: File.open(xls_file), headers: {})
      end

      it 'does not create a Document' do
        expect { post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/document-upload', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not do the PUT request' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(HTTParty).not_to have_received(:put)
      end

      it 'returns status code 422' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response.body).to include('You are not allowed to upload') 
      end
    end

    context 'when type_validation is a blank array' do
      let(:invalid_attributes) { { document_file: pdf_file, type_validation: [''], size_validation: 1000000 } }

      it 'does not create a Document' do
        expect { post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/document-upload', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not do the PUT request' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(HTTParty).not_to have_received(:put)
      end

      it 'returns status code 422' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response.body).to include("can't be blank")
      end
    end

    context 'when type_validation is a nil' do
      let(:invalid_attributes) { { document_file: pdf_file, type_validation: nil, size_validation: 1000000 } }

      it 'does not create a Document' do
        expect { post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/document-upload', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not do the PUT request' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(HTTParty).not_to have_received(:put)
      end

      it 'returns status code 422' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response.body).to include("can't be blank")
      end
    end

    context 'when type_validation is not sent through' do
      let(:invalid_attributes) { { document_file: pdf_file, size_validation: 1000000 } }

      it 'does not create a Document' do
        expect { post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/document-upload', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not do the PUT request' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(HTTParty).not_to have_received(:put)
      end

      it 'returns status code 422' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response.body).to include("can't be blank")
      end
    end

    context 'when size_validation is blank' do
      let(:invalid_attributes) { { document_file: pdf_file, type_validation: ['pdf'], size_validation: nil } }

      it 'does not create a Document' do
        expect { post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/document-upload', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not do the PUT request' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(HTTParty).not_to have_received(:put)
      end

      it 'returns status code 422' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response.body).to include("can't be blank")
      end
    end

    context 'when size_validation is not sent through' do
      let(:invalid_attributes) { { document_file: pdf_file, type_validation: ['pdf'] } }

      it 'does not create a Document' do
        expect { post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/document-upload', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not do the PUT request' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(HTTParty).not_to have_received(:put)
      end

      it 'returns status code 422' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response.body).to include("can't be blank")
      end
    end

    context 'when size_validation is not a number' do
      let(:invalid_attributes) { { document_file: pdf_file, type_validation: ['pdf'], size_validation: 'test' } }

      it 'does not create a Document' do
        expect { post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/document-upload', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not do the PUT request' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(HTTParty).not_to have_received(:put)
      end

      it 'returns status code 422' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(response.body).to include(I18n.t('unchecked_document.size_validation.not_a_number'))
      end
    end

    context 'when size validation fails' do
      let(:invalid_attributes) { { document_file: pdf_file, type_validation: ['pdf'], size_validation: 2000 } }

      it 'does not create a Document' do
        expect { post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/document-upload', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not do the PUT request' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(HTTParty).not_to have_received(:put)
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
      let(:invalid_attributes) do
        { document_file: pdf_file, type_validation: ['pdf'],
          size_validation: UncheckedDocument::FIVE_GIGABITES_IN_BYTES + 1 }
      end

      it 'does not create a Document' do
        expect { post '/document-upload', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/document-upload', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not do the PUT request' do
        post '/document-upload', params: invalid_attributes, headers: headers
        expect(HTTParty).not_to have_received(:put)
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
      let(:headers) do
        {
          'ACCEPT' => 'application/json',
          'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials('test', 'test')
        }
      end

      context 'when posting a file' do
        let(:valid_attributes) { { document_file: pdf_file, type_validation: ['pdf'], size_validation: 1000000 } }

        it 'creates a Document' do
          expect do
            post '/document-upload', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(0)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/document-upload', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(0)
        end

        it 'does not do the PUT request' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(HTTParty).not_to have_received(:put)
        end

        it 'returns status code 201' do
          post '/document-upload', params: valid_attributes, headers: headers
          expect(response).to have_http_status(401)
        end
      end
    end
  end
end
