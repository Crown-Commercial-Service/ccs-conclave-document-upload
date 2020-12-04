require 'rails_helper'

RSpec.describe UncheckedDocument, type: :model do
  let(:file_path) { fixture_file_upload('test_pdf.pdf', 'text/pdf').path }

  describe '.grab_image' do
    let(:unchecked_document) { create(:unchecked_document, document_file_path: file_path) }

    context 'when document_file_path is present' do
      it 'updates document_file record' do
        expect(unchecked_document.document_file.attached?).to eq true
      end
    end

    context 'when document_file_path is not present' do
      let(:file_path) { nil }

      it 'does not updates document_file record' do
        expect(unchecked_document.document_file.attached?).to eq false
      end
    end
  end
end
