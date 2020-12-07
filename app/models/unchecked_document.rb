require 'open-uri'

class UncheckedDocument < ApplicationRecord

  FIVE_GIGABITES_IN_BYTES = 5368709120

  belongs_to :document
  has_one_attached :document_file

  attr_accessor :document_file_path
  attr_accessor :type_validation
  attr_accessor :size_validation
  attr_accessor :service_name

  [:type_validation ,:size_validation].each do |column|
    validates_presence_of column
  end

  # validate :file_xor_file_path
  validates :document_file, attached: true, unless: :document_file_path
  # validate :document_type
  # validate :document_size
  validate :max_size

  before_validation :grab_image, if: :document_file_path

  private

  def file_xor_file_path
    byebug
    if document_file_path.blank? || !document_file.attached?
      errors.add(:base, "Specify document file or a file path")
    end
  end

  def document_type
    if document_file.attached?
      if type_validation.none?{|t| document_file.blob.content_type.include?(t)}
        document_file.purge
        errors.add(:base, 'Wrong format')
      end
    end
  end

  def document_size
    if document_file.attached?
      if document_file.blob.byte_size > size_validation.to_i
        document_file.purge
        errors.add(:base, 'File too big')
      end
    end
  end

  def max_size
    errors.add(:base, 'Maximum file size is 5gb.') if size_validation.to_i > FIVE_GIGABITES_IN_BYTES
  end

  def grab_image
    downloaded_image = URI.open(document_file_path)
    self.document_file.attach(io: downloaded_image, filename: File.basename(document_file_path))
  end
end