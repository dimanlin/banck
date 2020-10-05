FactoryBot.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :first_name do |n|
    "first_name_#{n}"
  end

  sequence :last_name do |n|
    "last_name_#{n}"
  end

  sequence :phone_number do |n|
    "+7929018832#{n}"
  end

  sequence :postal_code do |n|
    "12345#{n}"
  end

  sequence :document_number do |n|
    "12345#{n}"
  end

  factory :user do
    email { generate :email }
    aml_rules { true }
    first_name { generate :first_name }
    last_name { generate :last_name }
    phone_number { generate :phone_number }
    dob { 27.years.ago }
    country { User::COUNTRIES.sample }
    nationality { User::COUNTRIES.sample }
    postal_code { generate :postal_code }
    country_document { User::COUNTRIES.sample }
    document_type { User::DOCUMENT_TYPE.sample }
    document_number { generate :document_number }
  end
end
