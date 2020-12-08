class Client < ApplicationRecord
  validates_presence_of :source_app, :api_key
  validates_uniqueness_of :source_app, :api_key

  has_many :unchecked_documents

  before_validation :set_api_key

  private

  def set_api_key
    self.api_key = ApiKey.generator
  end
end
