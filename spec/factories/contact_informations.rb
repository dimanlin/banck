FactoryBot.define do
  factory :contact_information do
    first_name { "MyString" }
    last_name { "MyString" }
    phone_number { "MyString" }
    dob { "2020-10-06" }
    user_id { 1 }
  end
end
