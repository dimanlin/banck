class Document < ApplicationRecord
  enum document_type: { 'Passport' => 0,
                       'Driving license' => 1,
                       'ID' => 2 }

  belongs_to :user

  validates :user_id, :country, :document_type, :issued_at, presence: true

  validates :country, exclusion: { in: ISO3166::Country.all_translated('EN') }
end
