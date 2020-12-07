require 'open-uri'

class UncheckedDocument < ApplicationRecord

  FIVE_GIGABITES_IN_BYTES = 5368709120

  belongs_to :document
  mount_uploader :document_file, DocumentFileUploader

  attr_accessor :document_file_path
  attr_accessor :type_validation
  attr_accessor :size_validation
  attr_accessor :source_app

  [:type_validation ,:size_validation].each do |column|
    validates_presence_of column
  end

  validate :file_xor_file_path
  validate :document_type
  validate :document_size
  validate :max_size

  before_validation :grab_image, if: :document_file_path
  before_validation :create_document

  private

  def file_xor_file_path
    unless document_file.file.present?
      errors.add(:base, "Specify document file or a file path")
    end
  end

  def document_type
    return unless document_file.file.present?

    if type_validation.none?{|t| document_file.file.content_type.include?(t)}
      errors.add(:base, 'Wrong format')
    end
  end

  def document_size
    return unless document_file.file.present?

    if document_file.file.size > size_validation.to_i
      errors.add(:base, 'File too big')
    end
  end

  def max_size
    errors.add(:base, 'Maximum file size is 5gb.') if size_validation.to_i > FIVE_GIGABITES_IN_BYTES
  end

  def grab_image
    self.remote_document_file_url = document_file_path if document_file_path
  end

  def create_document
    self.document = Document.new(source_app: source_app)
  end
end