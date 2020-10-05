class Address < ApplicationRecord
  belongs_to :user

  validates :city, :country, :address, :postal_code, presence: true

  validates :country, exclusion: { in: ISO3166::Country.all_translated('EN') }
  validates :city, exclusion: { in: ISO3166::Country.find_country_by_name(self.country).states.map {|a| a.last.name} }

end
