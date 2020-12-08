FactoryBot.define do
  factory :unchecked_document do
    document { build(:document) }
    client { build(:client) }
  end
end