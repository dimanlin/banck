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

  factory :user do
    transient do
      with_contact_information { false }
    end

    email { generate :email }
    nationality { ISO3166::Country.all_translated('EN').sample }
    password { 'password' }
    password_confirmation { 'password' }
    country { ISO3166::Country.all_translated('EN').sample }
    over_18 { true }
    agree_with_terms { true }
    aml_rules { true }


    after(:create) do |user, evaluator|
      user.contact_information ||= create(:contact_information, user: user) if evaluator.with_contact_information
    end
  end
end
