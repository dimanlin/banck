class User < ApplicationRecord
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one :contact_information
  has_one :address
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

end
