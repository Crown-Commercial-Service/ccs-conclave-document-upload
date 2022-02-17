class Client < ApplicationRecord
  validates :source_app, :api_key, presence: true
  validates :source_app, :api_key, uniqueness: true

  has_many :unchecked_documents, dependent: :restrict_with_exception

  before_validation :set_api_key

  private

  def set_api_key
    self.api_key = ApiKey.generator
  end
end
