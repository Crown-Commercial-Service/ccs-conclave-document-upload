require 'rails_helper'

RSpec.describe 'DocumentUploads', type: :request do
  let(:pdf_file) { fixture_file_upload('test_pdf.pdf', 'text/pdf') }

  # Test suite for POST /documents
  describe 'POST /documents' do
    let(:client) { create(:client, source_app: 'evidence_locker') }

    let(:headers) do
      {
        'ACCEPT' => 'application/json',
        'x-api-key' => ActionController::HttpAuthentication::Basic.encode_credentials(client.source_app,
                                                                                      client.api_key)
      }
    end

    context 'when success' do
      let(:file) { fixture_file_upload(file_name, mime_type) }
      let(:valid_attributes) { { document_file: file, type_validation: [mime_type], size_validation: 10000000 } }

      context 'when posting a pdf file' do
        let(:mime_type) { 'text/pdf' }
        let(:file_name) { 'test_pdf.pdf' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is csv' do
        let(:mime_type) { 'text/csv' }
        let(:file_name) { 'test_csv.csv' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is xlsx' do
        let(:mime_type) { 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' }
        let(:file_name) { 'test_xlsx.xlsx' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is xls' do
        let(:mime_type) { 'application/vnd.ms-excel' }
        let(:file_name) { 'test_xls.xls' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is docx' do
        let(:mime_type) { 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' }
        let(:file_name) { 'test_docx.docx' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is doc' do
        let(:mime_type) { 'application/msword' }
        let(:file_name) { 'test_doc.doc' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is odt' do
        let(:mime_type) { 'application/vnd.oasis.opendocument.text' }
        let(:file_name) { 'test_odt.odt' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is odp' do
        let(:mime_type) { 'application/vnd.oasis.opendocument.presentation' }
        let(:file_name) { 'test_odp.odp' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is ods' do
        let(:mime_type) { 'application/vnd.oasis.opendocument.spreadsheet' }
        let(:file_name) { 'test_ods.ods' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is odg' do
        let(:mime_type) { 'application/vnd.oasis.opendocument.graphics' }
        let(:file_name) { 'test_odg.odg' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is zip' do
        let(:mime_type) { 'application/zip' }
        let(:file_name) { 'test_zip.zip' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is rar' do
        let(:mime_type) { 'application/vnd.rar' }
        let(:file_name) { 'test_rar.rar' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is tar.gz' do
        let(:mime_type) { 'application/gzip' }
        let(:file_name) { 'test_targz.tar.gz' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is tgz' do
        let(:mime_type) { 'application/tar+gzip' }
        let(:file_name) { 'test_tgz.tgz' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is jpg' do
        let(:mime_type) { 'image/jpeg' }
        let(:file_name) { 'test_jpg.jpg' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is jpeg' do
        let(:mime_type) { 'image/jpeg' }
        let(:file_name) { 'test_jpeg.jpeg' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is bmp' do
        let(:mime_type) { 'image/bmp' }
        let(:file_name) { 'test_bmp.bmp' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is png' do
        let(:mime_type) { 'image/png' }
        let(:file_name) { 'test_png.png' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is tiff' do
        let(:mime_type) { 'image/tiff' }
        let(:file_name) { 'test_tiff.tiff' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is tif' do
        let(:mime_type) { 'image/tiff' }
        let(:file_name) { 'test_tif.tif' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when file is eps' do
        let(:mime_type) { 'application/eps' }
        let(:file_name) { 'test_eps.eps' }

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when posting a document_file_path' do
        let(:file_path) { 'https://www.example.com/test_pdf.pdf' }
        let(:valid_attributes) do
          { document_file_path: file_path, type_validation: ['octet-stream'], size_validation: 1000000 }
        end

        before do
          stub_request(:get, 'https://93.184.216.34/test_pdf.pdf')
            .with(
              headers: {
                'Accept' => '*/*',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Host' => 'www.example.com',
                'User-Agent' => 'CarrierWave/2.1.1'
              }
            )
            .to_return(status: 200, body: File.open(pdf_file), headers: {})
        end

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(201)
        end
      end

      context 'when posting a file and document_file_path is blank' do
        let(:valid_attributes) do
          { document_file_path: '', document_file: pdf_file, type_validation: ['pdf'], size_validation: 1000000 }
        end

        it 'creates a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(1)
        end

        it 'creates an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(1)
        end

        it 'starts the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
        end

        it 'returns status code 201' do
          post '/documents', params: valid_attributes, headers: headers
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
        stub_request(:get, 'http://93.184.216.34/test_pdf.pdf')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Host' => 'www.example.com',
              'User-Agent' => 'CarrierWave/2.1.1'
            }
          )
          .to_return(status: 200, body: File.open(pdf_file), headers: {})
      end

      it 'creates a Document' do
        expect { post '/documents', params: valid_attributes, headers: headers }.to change(Document, :count).by(1)
      end

      it 'creates an UncheckedDocument' do
        expect do
          post '/documents', params: valid_attributes, headers: headers
        end.to change(UncheckedDocument, :count).by(1)
      end

      it 'starts the check request background job' do
        post '/documents', params: valid_attributes, headers: headers
        expect(CallCheckServiceWorker).to have_enqueued_sidekiq_job(UncheckedDocument.take.id)
      end

      it 'returns status code 201' do
        post '/documents', params: valid_attributes, headers: headers
        expect(response).to have_http_status(201)
      end
    end

    context 'when document_file and document_file_path parameters are missing' do
      let(:invalid_attributes) { { type_validation: ['pdf'], size_validation: 1000000 } }

      it 'does not create a Document' do
        expect { post '/documents', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/documents', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not start the check request background job' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(CallCheckServiceWorker).to_not have_enqueued_sidekiq_job
      end

      it 'returns status code 422' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response.body).to include(I18n.t('unchecked_document.base.no_file'))
      end
    end

    context 'when type validation fails' do
      let(:invalid_attributes) { { document_file: pdf_file, type_validation: %w[csv docx], size_validation: 1000000 } }

      it 'does not create a Document' do
        expect { post '/documents', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/documents', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not start the check request background job' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(CallCheckServiceWorker).to_not have_enqueued_sidekiq_job
      end

      it 'returns status code 422' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response.body).to include(I18n.t('unchecked_document.base.wrong_format'))
      end
    end

    context 'when file unsupported type' do
      let(:pptx_file) do
        fixture_file_upload('test_pptx.pptx',
                            'application/vnd.openxmlformats-officedocument.presentationml.presentation')
      end
      let(:invalid_attributes) do
        { document_file_path: '', document_file: pptx_file, type_validation: ['pptx'], size_validation: 1000000 }
      end

      it 'does not create a Document' do
        expect { post '/documents', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/documents', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not start the check request background job' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(CallCheckServiceWorker).to_not have_enqueued_sidekiq_job
      end

      it 'returns status code 422' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response.body).to include('You are not allowed to upload')
      end
    end

    context 'when file path unsupported type' do
      let(:pptx_file) do
        fixture_file_upload('test_pptx.pptx',
                            'application/vnd.openxmlformats-officedocument.presentationml.presentation')
      end
      let(:file_path) { 'https://www.example.com/test_pptx.pptx' }
      let(:invalid_attributes) do
        { document_file_path: file_path, type_validation: ['pptx'], size_validation: 1000000 }
      end

      before do
        stub_request(:get, 'https://93.184.216.34/test_pptx.pptx')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Host' => 'www.example.com',
              'User-Agent' => 'CarrierWave/2.1.1'
            }
          )
          .to_return(status: 200, body: File.open(pptx_file), headers: {})
      end

      it 'does not create a Document' do
        expect { post '/documents', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/documents', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not start the check request background job' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(CallCheckServiceWorker).to_not have_enqueued_sidekiq_job
      end

      it 'returns status code 422' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response.body).to include('You are not allowed to upload')
      end
    end

    context 'when type_validation is a blank array' do
      let(:invalid_attributes) { { document_file: pdf_file, type_validation: [''], size_validation: 1000000 } }

      it 'does not create a Document' do
        expect { post '/documents', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/documents', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not start the check request background job' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(CallCheckServiceWorker).to_not have_enqueued_sidekiq_job
      end

      it 'returns status code 422' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response.body).to include("can't be blank")
      end
    end

    context 'when type_validation is a nil' do
      let(:invalid_attributes) { { document_file: pdf_file, type_validation: nil, size_validation: 1000000 } }

      it 'does not create a Document' do
        expect { post '/documents', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/documents', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not start the check request background job' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(CallCheckServiceWorker).to_not have_enqueued_sidekiq_job
      end

      it 'returns status code 422' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response.body).to include("can't be blank")
      end
    end

    context 'when type_validation is not sent through' do
      let(:invalid_attributes) { { document_file: pdf_file, size_validation: 1000000 } }

      it 'does not create a Document' do
        expect { post '/documents', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/documents', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not start the check request background job' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(CallCheckServiceWorker).to_not have_enqueued_sidekiq_job
      end

      it 'returns status code 422' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response.body).to include("can't be blank")
      end
    end

    context 'when size_validation is blank' do
      let(:invalid_attributes) { { document_file: pdf_file, type_validation: ['pdf'], size_validation: nil } }

      it 'does not create a Document' do
        expect { post '/documents', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/documents', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not start the check request background job' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(CallCheckServiceWorker).to_not have_enqueued_sidekiq_job
      end

      it 'returns status code 422' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response.body).to include("can't be blank")
      end
    end

    context 'when size_validation is not sent through' do
      let(:invalid_attributes) { { document_file: pdf_file, type_validation: ['pdf'] } }

      it 'does not create a Document' do
        expect { post '/documents', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/documents', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not start the check request background job' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(CallCheckServiceWorker).to_not have_enqueued_sidekiq_job
      end

      it 'returns status code 422' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response.body).to include("can't be blank")
      end
    end

    context 'when size_validation is not a number' do
      let(:invalid_attributes) { { document_file: pdf_file, type_validation: ['pdf'], size_validation: 'test' } }

      it 'does not create a Document' do
        expect { post '/documents', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/documents', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'starts the check request background job' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(CallCheckServiceWorker).to_not have_enqueued_sidekiq_job
      end

      it 'returns status code 422' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response.body).to include(I18n.t('unchecked_document.size_validation.not_a_number'))
      end
    end

    context 'when size validation fails' do
      let(:invalid_attributes) { { document_file: pdf_file, type_validation: ['pdf'], size_validation: 2000 } }

      it 'does not create a Document' do
        expect { post '/documents', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/documents', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not start the check request background job' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(CallCheckServiceWorker).to_not have_enqueued_sidekiq_job
      end

      it 'returns status code 422' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response.body).to include(I18n.t('unchecked_document.base.file_too_big'))
      end
    end

    context 'when size validation is larger than 5gb' do
      let(:invalid_attributes) do
        { document_file: pdf_file, type_validation: ['pdf'],
          size_validation: UncheckedDocument::FIVE_GIGABITES_IN_BYTES + 1 }
      end

      it 'does not create a Document' do
        expect { post '/documents', params: invalid_attributes, headers: headers }.to_not change(Document, :count)
      end

      it 'does not create a UncheckedDocument' do
        expect do
          post '/documents', params: invalid_attributes, headers: headers
        end.to_not change(UncheckedDocument, :count)
      end

      it 'does not start the check request background job' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(CallCheckServiceWorker).to_not have_enqueued_sidekiq_job
      end

      it 'returns status code 422' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do
        post '/documents', params: invalid_attributes, headers: headers
        expect(response.body).to include(I18n.t('unchecked_document.base.max_file_size'))
      end
    end

    context 'when unauthorized' do
      let(:headers) do
        {
          'ACCEPT' => 'application/json',
          'x-api-key' => ActionController::HttpAuthentication::Basic.encode_credentials('test', 'test')
        }
      end

      context 'when posting a file' do
        let(:valid_attributes) { { document_file: pdf_file, type_validation: ['pdf'], size_validation: 1000000 } }

        it 'does not create a Document' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(Document, :count).by(0)
        end

        it 'does not create an UncheckedDocument' do
          expect do
            post '/documents', params: valid_attributes, headers: headers
          end.to change(UncheckedDocument, :count).by(0)
        end

        it 'does not start the check request background job' do
          post '/documents', params: valid_attributes, headers: headers
          expect(CallCheckServiceWorker).to_not have_enqueued_sidekiq_job
        end

        it 'returns status code 401' do
          post '/documents', params: valid_attributes, headers: headers
          expect(response).to have_http_status(401)
        end
      end
    end
  end
end
