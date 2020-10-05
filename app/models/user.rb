class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  COUNTRIES = [ :russia, :iran ]
  # enum nationality: [ :russia, :iran ]
  # enum country: COUNTRIES
  # enum country_document: COUNTRIES
  # enum document_type: [:passport, :"driver's license"]
end
