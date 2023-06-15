require 'rails_helper'

RSpec.describe 'DocumentUploads', type: :request do
  # let(:pdf_file) { fixture_file_upload('test_pdf.pdf', 'text/pdf') }
  let(:pdf_file) { Rack::Test::UploadedFile.new('spec/fixtures/test_pdf.pdf', 'text/pdf') }

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
      # let(:file) { fixture_file_upload(file_name, mime_type) }
      let(:file) { Rack::Test::UploadedFile.new("spec/fixtures/#{file_name}", mime_type) }
      let(:valid_attributes) { { documentFile: file, typeValidation: [mime_type], sizeValidation: 10000000 } }

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

      context 'when file is txt' do
        let(:mime_type) { 'text/plain' }
        let(:file_name) { 'test_txt.txt' }

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

      context 'when file is xml' do
        let(:mime_type) { 'application/xml' }
        let(:file_name) { 'test_xml.xml' }

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

      context 'when file is rtf' do
        let(:mime_type) { 'application/rtf' }
        let(:file_name) { 'test_rtf.rtf' }

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

      context 'when file is ppt' do
        let(:mime_type) { 'application/vnd.ms-powerpoint' }
        let(:file_name) { 'test_ppt.ppt' }

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

      context 'when file is pptx' do
        let(:mime_type) { 'application/vnd.openxmlformats-officedocument.presentationml.presentation' }
        let(:file_name) { 'test_pptx.pptx' }

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

      context 'when file is kml' do
        let(:mime_type) { 'application/vnd' }
        let(:file_name) { 'test_kml.kml' }

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

      context 'when file is rdf' do
        let(:mime_type) { 'application/rdf+xml' }
        let(:file_name) { 'test_rdf.rdf' }

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

      context 'when posting a documentFilePath' do
        let(:file_path) { 'https://www.example.com/test_pdf.pdf' }
        let(:valid_attributes) do
          { documentFilePath: file_path, typeValidation: ['octet-stream'], sizeValidation: 1000000 }
        end

        before do
          stub_request(:get, 'https://93.184.216.34/test_pdf.pdf')
            .with(
              headers: {
                'Accept' => '*/*',
                'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
                'Host' => 'www.example.com',
                'User-Agent' => 'CarrierWave/2.2.2'
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

      context 'when posting a file and documentFilePath is blank' do
        let(:valid_attributes) do
          { documentFilePath: '', documentFile: pdf_file, typeValidation: ['pdf'], sizeValidation: 1000000 }
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

    context 'when documentFilePath is missing protocol' do
      let(:file_path) { 'www.example.com/test_pdf.pdf' }
      let(:valid_attributes) do
        { documentFilePath: file_path, service_name: 'evidence_locker', typeValidation: ['octet-stream'],
          sizeValidation: 1000000 }
      end

      before do
        stub_request(:get, 'http://93.184.216.34/test_pdf.pdf')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Host' => 'www.example.com',
              'User-Agent' => 'CarrierWave/2.2.2'
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

    context 'when documentFile and documentFilePath parameters are missing' do
      let(:invalid_attributes) { { typeValidation: ['pdf'], sizeValidation: 1000000 } }

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
      let(:invalid_attributes) { { documentFile: pdf_file, typeValidation: %w[csv docx], sizeValidation: 1000000 } }

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
      # fixture_file_upload('test_html.html', 'text/html')
      let(:html_file) do
        Rack::Test::UploadedFile.new('spec/fixtures/test_html.html', 'text/html')
      end
      let(:invalid_attributes) do
        { documentFilePath: '', documentFile: html_file, typeValidation: ['html'], sizeValidation: 1000000 }
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
        expect(response.body).to include('Your document must be in ')
      end
    end

    context 'when file path unsupported type' do
      # fixture_file_upload('test_html.html', 'text/html')
      let(:html_file) do
        Rack::Test::UploadedFile.new('spec/fixtures/test_html.html', 'text/html')
      end
      let(:file_path) { 'https://www.example.com/test_html.html' }
      let(:invalid_attributes) do
        { documentFilePath: file_path, typeValidation: ['html'], sizeValidation: 1000000 }
      end

      before do
        stub_request(:get, 'https://93.184.216.34/test_html.html')
          .with(
            headers: {
              'Accept' => '*/*',
              'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
              'Host' => 'www.example.com',
              'User-Agent' => 'CarrierWave/2.2.2'
            }
          )
          .to_return(status: 200, body: File.open(html_file), headers: {})
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
        expect(response.body).to include('File not found')
        expect(response.body).to include('If you typed the file path, check it is correct')
        expect(response.body).to include('Check that your file type is in')
        expect(response.body).to include('If the file type and path are correct contact')
      end
    end

    context 'when typeValidation is a blank array' do
      let(:invalid_attributes) { { documentFile: pdf_file, typeValidation: [''], sizeValidation: 1000000 } }

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
        expect(response.body).to include('Fill in the field')
      end
    end

    context 'when typeValidation is a nil' do
      let(:invalid_attributes) { { documentFile: pdf_file, typeValidation: nil, sizeValidation: 1000000 } }

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
        expect(response.body).to include('Fill in the field')
      end
    end

    context 'when typeValidation is not sent through' do
      let(:invalid_attributes) { { documentFile: pdf_file, sizeValidation: 1000000 } }

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
        expect(response.body).to include('Fill in the field')
      end
    end

    context 'when sizeValidation is blank' do
      let(:invalid_attributes) { { documentFile: pdf_file, typeValidation: ['pdf'], sizeValidation: nil } }

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
        expect(response.body).to include('Fill in the field')
      end
    end

    context 'when sizeValidation is not sent through' do
      let(:invalid_attributes) { { documentFile: pdf_file, typeValidation: ['pdf'] } }

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
        expect(response.body).to include('Fill in the field')
      end
    end

    context 'when sizeValidation is not a number' do
      let(:invalid_attributes) { { documentFile: pdf_file, typeValidation: ['pdf'], sizeValidation: 'test' } }

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
      let(:invalid_attributes) { { documentFile: pdf_file, typeValidation: ['pdf'], sizeValidation: 2000 } }

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
        { documentFile: pdf_file, typeValidation: ['pdf'],
          sizeValidation: UncheckedDocument::FIVE_GIGABITES_IN_BYTES + 1 }
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
        let(:valid_attributes) { { documentFile: pdf_file, typeValidation: ['pdf'], sizeValidation: 1000000 } }

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
