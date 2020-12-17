require 'open-uri'

class UncheckedDocument < ApplicationRecord

  FIVE_GIGABITES_IN_BYTES = 5368709120

  belongs_to :document
  belongs_to :client
  mount_uploader :document_file, DocumentFileUploader

  attr_accessor :document_file_path
  attr_accessor :type_validation
  attr_accessor :size_validation

  [:type_validation ,:size_validation].each do |column|
    validates column, presence: true, allow_blank: false
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
      errors.add(:base, I18n.t('unchecked_document.base.no_file'))
    end
  end

  def document_type
    return unless document_file.file.present? && type_validation.present?

    errors.add(:type_validation, I18n.t('errors.messages.blank')) && return unless type_validation.reject { |c| c.empty? }.any?

    if type_validation.none?{|t| document_file.file.content_type.include?(t)}
      errors.add(:base, I18n.t('unchecked_document.base.wrong_format'))
    end
  end

  def document_size
    return unless document_file.file.present?

    errors.add(:size_validation, I18n.t('unchecked_document.size_validation.not_a_number')) && return unless size_validation.to_i.to_s == size_validation.to_s

    if document_file.file.size > size_validation.to_i
      errors.add(:base, I18n.t('unchecked_document.base.file_too_big'))
    end
  end

  def max_size
    errors.add(:base, I18n.t('unchecked_document.base.max_file_size')) if size_validation.to_i > FIVE_GIGABITES_IN_BYTES
  end

  def grab_image
    self.remote_document_file_url = document_file_path if document_file_path
  end

  def create_document
    self.document = Document.new(source_app: client.source_app)
  end
end