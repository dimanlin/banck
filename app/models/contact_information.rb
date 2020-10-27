class ContactInformation < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name, :phone_number, :dial_code, :dob, presence: true
  validate :age_check

  after_create :generate_phone_number_confirmation_code

  def age_check
    if dob.present? && 18.years.ago < dob
      errors.add(:dob, 'you are under 18')
    end
  end

  def confirm_phone_number(confirmation_number)
    return true if phone_confirm_at
    return false if confirmation_number.to_i != phone_code
    update(phone_confirm_at: DateTime.current)
  end


  private

  def generate_phone_number_confirmation_code
    self.update(phone_code: rand(100000..999999))
  end
end
