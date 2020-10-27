FactoryBot.define do
  factory :document do
    country { ISO3166::Country.all_translated('EN').sample }
    document_type { Document.document_types.keys.sample }
    issued_at { 5.years.ago }
    expired_at { 5.years.from_now }
    number { 123 }
  end
end
