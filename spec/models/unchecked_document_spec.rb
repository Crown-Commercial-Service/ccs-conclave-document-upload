require 'rails_helper'

RSpec.describe UncheckedDocument, type: :model do
  let(:document_file) { fixture_file_upload('test_pdf.pdf', 'text/pdf') }
  let(:file_path) { 'http://www.example.com/test_pdf.pdf' }

  describe 'callbacks' do
    let(:unchecked_document) do
      build(:unchecked_document, document_file_path: file_path, type_validation: ['pdf'], size_validation: 1000000)
    end

    before do
      stub_request(:get, 'http://93.184.216.34/test_pdf.pdf')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Host' => 'www.example.com'
          }
        )
        .to_return(status: 200, body: File.open(document_file), headers: {})
    end

    context '.grab_image' do
      context 'when document_file_path is present' do
        it 'updates document_file record' do
          unchecked_document.save
          expect(unchecked_document.document_file.present?).to eq true
        end
      end

      context 'when document_file_path is not present' do
        let(:file_path) { nil }

        it 'does not updates document_file record' do
          expect(unchecked_document.valid?).to eq false
        end
      end
    end

    context '.add_url_protocol' do
      let(:file_path) { 'www.example.com/test_pdf.pdf' }

      context 'when document_file_path is missing protocol' do
        it 'adds the protocol automatically and updates document_file record' do
          unchecked_document.save
          expect(unchecked_document.document_file.present?).to eq true
        end
      end
    end
  end

  describe 'relationship' do
    it 'has a connection to a client' do
      client = create(:client, source_app: 'myapp', api_key: 'RbZHfHtD1h9XZvs4fGPJUgtt')
      unchecked_doc = client.unchecked_documents.create!(document_file: document_file, type_validation: ['pdf'],
                                                         size_validation: 1000000)
      expect(unchecked_doc.document.source_app).to eq('myapp')
    end
  end

  describe 'validations' do
    let(:type_validation) { %w[pdf docx] }
    let(:size_validation) { 1000000 }
    let(:unchecked_document) do
      build(:unchecked_document, document_file: document_file, type_validation: type_validation,
                                 size_validation: size_validation)
    end

    context 'when path and file are missing' do
      let(:document_file) { nil }

      it 'returns false' do
        expect(unchecked_document.valid?).to eq false
      end
    end

    context 'when type_validation is missing' do
      let(:type_validation) { nil }

      it 'returns false' do
        expect(unchecked_document.valid?).to eq false
      end
    end

    context 'when size_validation is missing' do
      let(:size_validation) { nil }

      it 'returns false' do
        expect(unchecked_document.valid?).to eq false
      end
    end

    context 'when type is unsupported by CLAMAV (xls)' do
      let(:document_file) { fixture_file_upload('test_xls.xls') }
      let(:type_validation) { ['xls'] }

      it 'returns false' do
        expect(unchecked_document.valid?).to eq false
      end
    end

    context 'when size_validation is over 5gb' do
      let(:size_validation) { UncheckedDocument::FIVE_GIGABITES_IN_BYTES + 1 }

      it 'returns false' do
        expect(unchecked_document.valid?).to eq false
      end
    end

    context 'when file is not in the type_validation array' do
      let(:type_validation) { ['docx'] }

      it 'returns false' do
        expect(unchecked_document.valid?).to eq false
      end
    end

    context 'when file larger than the size_validation' do
      let(:size_validation) { 100 }

      it 'returns false' do
        expect(unchecked_document.valid?).to eq false
      end
    end
  end
end
