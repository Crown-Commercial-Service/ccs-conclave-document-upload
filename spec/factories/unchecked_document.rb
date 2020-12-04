FactoryBot.define do
  factory :unchecked_document do
    document { build(:document) }
  end
end