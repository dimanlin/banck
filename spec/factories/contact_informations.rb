FactoryBot.define do
  factory :contact_information do
    first_name { "MyString" }
    last_name { "MyString" }
    phone_number { "MyString" }
    dob { 20.years.ago }
    dial_code { '+1' }
  end
end
