class Address < ApplicationRecord
  belongs_to :user

  validates :city, :country, :address, :postal_code, presence: true

  validates :country, inclusion: { in: ISO3166::Country.all_translated('EN') }

  validate :city_validation

  private

  def city_validation
    return if ISO3166::Country.find_country_by_name(self.country).nil?
    states = ISO3166::Country.find_country_by_name(self.country).states
    city_names = states.map { |a| a.last.name }
    errors.add(:city, 'has no such city') unless city_names.include?(city)
  end

end
