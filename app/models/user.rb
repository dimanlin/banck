class User < ApplicationRecord
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :nationality, :country, presence: true
  validates :nationality, :country, inclusion: { in: ISO3166::Country.all_translated('EN') }

  has_one :contact_information
  has_one :document

  def confirm_phone_number(confirmation_number)
    return true if contact_information.phone_confirm_at
    return false if confirmation_number.to_i != contact_information.phone_code
    contact_information.update(phone_confirm_at: DateTime.current)
  end

  def has_contact_information?
    contact_information.present?
  end

  def has_address?
    address.present?
  end

  def has_document?
    document.present?
  end

  private

  def city_validation
    return if ISO3166::Country.find_country_by_name(self.country).nil?
    states = ISO3166::Country.find_country_by_name(self.country).states
    city_names = states.map { |a| a.last.name }
    errors.add(:city, 'has no such city') unless city_names.include?(city)
  end

end
