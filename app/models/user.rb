class User < ApplicationRecord
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :nationality, :country, presence: true
  validates :nationality, :country, inclusion: { in: ISO3166::Country.all_translated('EN') }
  validates :agree_with_terms, :aml_rules, :over_18, inclusion: { in: [ true ] }

  has_one :contact_information
  has_one :document

  def has_contact_information?
    contact_information.present?
  end

  def has_address?
    address.present?
  end

  def has_document?
    document.present?
  end

  def update_email(email)
    @skip_confirmation_notification = true
    update(email: email, email_code: generate_code)
  end

  def confirm_email(code)
    if code.to_i == email_code
      confirm
      update(email_code: nil)
    end
  end

  private

  def send_reconfirmation_instructions
    @reconfirmation_required = false

    unless @skip_confirmation_notification
      send_confirmation_instructions
    else
      if self.email.present? && self.unconfirmed_email.present?
        SmsClient.send_sms(contact_information.phone_number, email_code)
      end
    end
  end

  def city_validation
    return if ISO3166::Country.find_country_by_name(self.country).nil?
    states = ISO3166::Country.find_country_by_name(self.country).states
    city_names = states.map { |a| a.last.name }
    errors.add(:city, 'has no such city') unless city_names.include?(city)
  end

  def generate_code
    rand(100000..999999)
  end

end
