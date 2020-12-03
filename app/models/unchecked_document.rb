class UncheckedDocument < ApplicationRecord
  belongs_to :document
  has_one_attached :document_file
end
