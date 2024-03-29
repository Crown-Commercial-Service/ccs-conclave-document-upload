require 'open-uri'

class UncheckedDocument < ApplicationRecord
  FIVE_GIGABITES_IN_BYTES = 5368709120

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

    return if @errors.present?

    errors.add(:base, I18n.t('unchecked_document.base.no_file')) if document_file.file.blank?
  end

  def document_type
    return unless document_file.file.present? && type_validation.present?

    valid_type
    return if @errors.present?

    errors.add(:base, I18n.t('unchecked_document.base.wrong_format')) if type_validation.none? do |t|
                                                                           document_file.file.content_type.include?(t)
                                                                         end
  end

  def document_size
    return if document_file.file.blank?

    valid_number
    return if @errors.present?

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
