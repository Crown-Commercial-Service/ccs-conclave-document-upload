require 'open-uri'

class UncheckedDocument < ApplicationRecord
  FIVE_GIGABITES_IN_BYTES = 5368709120
  CONTENT_TYPES = {
    'pdf' => [
      'application/pdf'
    ],

    'ppt' => [
      'application/vnd.ms-powerpoint',
      'application/mspowerpoint',
      'application/x-mspowerpoint',
      'application/vnd.ms-office'
    ],

    'pptx' => [
      'application/vnd.openxmlformats-officedocument.presentationml.presentation',
      'application/zip'
    ],

    'csv' => [
      'text/csv',
      'application/csv',
      'application/vnd.ms-excel',
      'text/plain'
    ],

    'xls' => [
      'application/vnd.ms-excel',
      'application/x-ole-storage',
      'application/x-msexcel',
      'application/vnd.ms-office'
    ],

    'xlsx' => [
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'application/vnd.ms-excel',
      'application/zip'
    ],

    'doc' => [
      'application/msword',
      'application/x-ole-storage',
      'application/vnd.ms-word',
      'application/vnd.ms-office'
    ],

    'docx' => [
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'application/vnd.ms-word',
      'application/zip'
    ],

    'odt' => [
      'application/vnd.oasis.opendocument.text',
      'application/x-vnd.oasis.opendocument.text'
    ],

    'odp' => [
      'application/vnd.oasis.opendocument.presentation',
      'application/x-vnd.oasis.opendocument.presentation'
    ],

    'ods' => [
      'application/vnd.oasis.opendocument.spreadsheet',
      'application/x-vnd.oasis.opendocument.spreadsheet'
    ],

    'odg' => [
      'application/vnd.oasis.opendocument.graphics',
      'application/x-vnd.oasis.opendocument.graphics'
    ],

    'zip' => [
      'application/zip',
      'application/x-zip-compressed'
    ],

    'rar' => [
      'application/vnd.rar',
      'application/x-rar-compressed',
      'application/x-rar'
    ],

    'tar.gz' => [
      'application/gzip',
      'application/x-gzip',
      'application/x-tar',
      'application/octet-stream'
    ],

    'tgz' => [
      'application/gzip',
      'application/x-gzip',
      'application/x-compressed-tar'
    ],

    'gz' => [
      'application/gzip',
      'application/x-gzip',
      'application/x-tar',
      'application/octet-stream'
    ],

    'kml' => [
      'application/vnd.google-earth.kml+xml',
      'application/xml',
      'text/xml'
    ],

    'jpg' => [
      'image/jpeg',
      'image/pjpeg'
    ],

    'jpeg' => [
      'image/jpeg',
      'image/pjpeg'
    ],

    'png' => [
      'image/png'
    ],

    'bmp' => [
      'image/bmp',
      'image/x-ms-bmp'
    ],

    'tiff' => [
      'image/tiff'
    ],

    'tif' => [
      'image/tiff'
    ],

    'eps' => [
      'application/postscript',
      'image/eps',
      'image/x-eps'
    ],

    'rdf' => [
      'application/rdf+xml',
      'application/xml',
      'text/xml'
    ],

    'rtf' => [
      'application/rtf',
      'text/rtf'
    ],

    'txt' => [
      'text/plain'
    ],

    'xml' => [
      'application/xml',
      'text/xml',
      'application/xml-dtd'
    ]
  }.freeze

  belongs_to :document
  belongs_to :client
  mount_uploader :document_file, DocumentFileUploader

  attr_accessor :document_file_path, :type_validation, :size_validation

  %i[type_validation size_validation].each do |column|
    validates column, presence: true, allow_blank: false
  end

  before_validation :add_url_protocol, if: :document_file_path
  before_validation :grab_image, if: :document_file_path
  before_validation :create_document

  validate :file_xor_file_path
  validate :document_type
  validate :document_size
  validate :max_size

  private

  def file_xor_file_path
    valid_file_path

    return if errors.present?

    errors.add(:base, I18n.t('unchecked_document.base.no_file')) if document_file.file.blank?
  end

  def document_type
    return unless document_file.file.present? && type_validation.present?

    valid_type
    return if errors.present?

    detected_content_type = document_file.file.content_type.to_s.downcase.split(';').first.strip
    extension = File.extname(document_file.file.filename).delete('.').downcase

    allowed_content_types = accepted_content_types(extension)

    unless allowed_content_types.map(&:downcase).include?(detected_content_type)
      errors.add(:base, I18n.t('unchecked_document.base.wrong_format'))
    end
  end

  def accepted_content_types(extension)
    CONTENT_TYPES.fetch(extension) do
      type_validation.map do |type|
        Marcel::MimeType.for(extension: type)
      end
    end
  end

  def document_size
    return if document_file.file.blank?

    valid_number
    return if errors.present?

    if document_file.file.size > size_validation.to_i
      errors.add(:base, I18n.t('unchecked_document.base.file_too_big')) && errors.add(:base, I18n.t('unchecked_document.base.file_must_be_under_max'))
    end
  end

  def max_size
    errors.add(:base, I18n.t('unchecked_document.base.max_file_size')) if size_validation.to_i > FIVE_GIGABITES_IN_BYTES
  end

  def valid_file_path
    if document_file.file.blank? && document_file_path.present?
      errors.messages[:document_file] = 'File not found'
      errors.add(:base, I18n.t('unchecked_document.base.check_file_path'))
      errors.add(:base, I18n.t('unchecked_document.base.check_file_type'))
      errors.add(:base, I18n.t('unchecked_document.base.contact_customer_service'))
    end
  end

  def valid_number
    return if size_validation.to_i.to_s == size_validation.to_s

    errors.add(:size_validation, I18n.t('unchecked_document.size_validation.not_a_number'))
  end

  def valid_type
    return if type_validation.reject(&:empty?).present?

    errors.add(:type_validation, I18n.t('errors.messages.blank'))
  end

  def grab_image
    self.remote_document_file_url = document_file_path if document_file_path
  end

  def create_document
    self.document = Document.new(source_app: client.source_app)
  end

  def add_url_protocol
    return if document_file_path[%r{\Ahttp://}] || document_file_path[%r{\Ahttps://}]

    self.document_file_path = "http://#{document_file_path}"
  end
end
