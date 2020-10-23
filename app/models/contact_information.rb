class ContactInformation < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name, :phone_number, :dial_code, :dob, presence: true
  validate :age_check

  def age_check
    if dob.present? && 18.years.ago < dob
      errors.add(:dob, 'you are under 18')
    end
  end
end
