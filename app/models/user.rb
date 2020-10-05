class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  COUNTRIES = %w('Russia', 'Iran')
  DOCUMENT_TYPE = %w('Pasport', "Driver's license")
end
