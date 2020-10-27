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

  def update_email(email)
    update(new_email: email, email_code: generate_code)
  end

  def confirm_email(code)
    if code == email_code
      update(email: new_email, email_code: nil)
    else
      false
    end
  end

  private

  def generate_phone_number_confirmation_code
    self.update(phone_code: generate_code)
  end

  def generate_code
    rand(100000..999999)
  end
end
