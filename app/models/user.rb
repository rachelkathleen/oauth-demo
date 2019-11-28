class User < ApplicationRecord
    validates :name, :email, presence: true
    validates :name, :email, uniqueness: true
    has_secure_password  #password validations
  
    def self.from_omniauth(auth)
      #Creates a new user only if it doesn't exist
      binding.pry
      where(email: auth.info.email).first_or_initialize do |user|
        user.name = auth.info.name
        user.email = auth.info.email
        user.password = SecureRandom.hex
      end
    end
  end
