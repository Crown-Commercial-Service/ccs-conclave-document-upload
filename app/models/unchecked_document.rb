class UncheckedDocument < ApplicationRecord
  belongs_to :document
  has_one_attachment :document_file
end
