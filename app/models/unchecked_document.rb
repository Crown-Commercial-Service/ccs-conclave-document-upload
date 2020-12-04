class UncheckedDocument < ApplicationRecord
  belongs_to :document
  has_one_attached :document_file

  attr_accessor :document_file_path

  before_save :grab_image, if: :document_file_path

  private

  def grab_image
    downloaded_image = open(document_file_path)
    self.document_file.attach(io: downloaded_image, filename: File.basename(document_file_path))
  end
end
